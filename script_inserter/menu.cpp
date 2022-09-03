#include <cstdio>
#include <cstring>
#include <map>
#include <string>
#include <vector>
#include "expr.h"
#include "sjis.h"
#include "tokenizer.h"

static void usage(FILE *out, const char *argv0) {
	fprintf(out, "Usage: %s [--args] image.gba script.txt...\n", argv0);
	fprintf(out, "\n");
	fprintf(out, "   --dry-run       Test insertion only, don't modify image\n");
	fprintf(out, "   --no-patch      Use only encodings supported unpatched\n");
	fprintf(out, "   --quiet         Output only errors\n");
}

struct Args {
	std::string image;
	std::vector<std::string> script;
	bool dryRun = false;
	bool quiet = false;
	bool noPatch = false;
};

static int parse_args(Args &result, int argc, char *argv[]) {
	bool argsDone = false;

	for (int i = 1; i < argc; ++i) {
		if (argv[i][0] == '-' && !argsDone) {
			if (!strcmp(argv[i], "--help")) {
				usage(stdout, argv[0]);
				return 0;
			}
			if (!strcmp(argv[i], "--dry-run")) {
				result.dryRun = true;
			} else if (!strcmp(argv[i], "--quiet")) {
				result.quiet = true;
			} else if (!strcmp(argv[i], "--no-patch")) {
				result.noPatch = true;
			} else if (!strcmp(argv[i], "--")) {
				argsDone = true;
			} else {
				usage(stderr, argv[0]);
				fprintf(stderr, "\nERROR: Unknown argument: %s\n", argv[i]);
				return 1;
			}
			continue;
		}

		if (result.image.empty()) {
			result.image = argv[i];
		} else {
			result.script.push_back(argv[i]);
		}
	}

	if (result.image.empty() || result.script.empty()) {
		usage(stderr, argv[0]);
		fprintf(stderr, "\nERROR: Insufficient arguments");
		return 2;
	}

	FILE *fp;
	fp = fopen(result.image.c_str(), "rb+");
	if (!fp) {
		usage(stderr, argv[0]);
		fprintf(stderr, "\nERROR: Could not open file: %s", result.image.c_str());
		return 2;
	}
	fclose(fp);

	for (const auto &script : result.script) {
		fp = fopen(script.c_str(), "rb");
		if (!fp) {
			usage(stderr, argv[0]);
			fprintf(stderr, "\nERROR: Could not open file: %s", script.c_str());
			return 2;
		}
		fclose(fp);
	}

	return 0;
}

std::string read_source(const std::string &filename) {
	FILE *fp = fopen(filename.c_str(), "rb");
	if (!fp) {
		return "";
	}

	std::string contents;
	fseek(fp, 0, SEEK_END);
	contents.resize(ftell(fp));
	rewind(fp);
	if (fread(&contents[0], 1, contents.size(), fp) != contents.size()) {
		contents.clear();
	}
	fclose(fp);

	return contents;
}

enum class MenuInsertType {
	BUFFER,
	RELOCATABLE_POINTER,
};

struct MenuInsert {
	MenuInsertType type;
	uint32_t ptr;
	uint32_t pos;
	uint32_t size;
	std::vector<uint8_t> update;
	std::string script;
	TokenPos scriptpos;
};

struct MenuFree {
	uint32_t base;
	uint32_t size;
};

struct MenuScript {
	std::vector<MenuInsert> inserts;
	std::vector<MenuFree> frees;
};

bool parse_menu_script(MenuScript &script, Tokens &tokens, const std::string &filename, bool noPatch) {
	struct {
		uint32_t ptr;
		uint32_t stride;
		uint32_t size;
	} table_params;

	auto failWithError = [&](const char *message, const TokenPos &pos) {
		fprintf(stderr, "%s on line %u, column %u in %s\n", message, pos.line, pos.col, filename.c_str());
		return false;
	};

	std::vector<uint32_t> args;
	auto parseNumArgs = [&](int n) {
		args.resize(n);
		for (int i = 0; i < n; ++i) {
			if (i != 0 && !tokens.next(TokenType::COMMA)) {
				return failWithError("Expecting comma after argument", tokens.peek().pos);
			}
			const Token &start = tokens.peek();
			Expression expr(tokens, noPatch);
			if (!expr.parse(ExpressionParse::AS_32BIT)) {
				return failWithError(expr.error().c_str(), expr.errorPos());
			}
			if (!expr.isConstant()) {
				return failWithError("Expression must be a constant value", start.pos);
			}
			args[i] = expr.asConstant();
		}
		return true;
	};

	while (!tokens.peek(TokenType::END_FILE)) {
		if (tokens.next(TokenType::END_LINE)) {
			continue;
		}
		if (!tokens.peek(TokenType::COMMAND)) {
			return failWithError("Expecting command", tokens.peek().pos);
		}

		const Token &command = tokens.next();
		if (command.str() == "free") {
			if (!parseNumArgs(2)) {
				return false;
			}
			if (!tokens.next(TokenType::END_LINE)) {
				return failWithError("Unexpected arguments", tokens.peek().pos);
			}
			script.frees.push_back({ args[0], args[1] });
		} else if (command.str() == "table") {
			if (!parseNumArgs(3)) {
				return false;
			}
			if (!tokens.next(TokenType::END_LINE)) {
				return failWithError("Unexpected arguments", tokens.peek().pos);
			}

			table_params.ptr = args[0];
			table_params.stride = args[1];
			table_params.size = args[2];
		} else if (command.str() == "tabletxt") {
			if (!parseNumArgs(1)) {
				return false;
			}
			if (!tokens.next(TokenType::COMMA) || !tokens.peek(TokenType::STRING)) {
				return failWithError("Expecting number, string parameters", tokens.peek().pos);
			}

			const Token &str = tokens.next();
			std::vector<uint8_t> sjis;
			if (escaped_utf8_to_game_sjis(str.sval, str.slen, sjis, noPatch) == -1) {
				return failWithError("Could not encode string", str.pos);
			}

			if (!tokens.next(TokenType::END_LINE)) {
				return failWithError("Unexpected arguments", tokens.peek().pos);
			}

			uint32_t pos = table_params.ptr + args[0] * table_params.stride;
			script.inserts.push_back({ MenuInsertType::BUFFER, 0, pos, table_params.size, sjis, filename, command.pos });
		} else if (command.str() == "dictionarytxt") {
			if (!parseNumArgs(1)) {
				return false;
			}
			if (!tokens.ahead({ TokenType::COMMA, TokenType::STRING, TokenType::COMMA, TokenType::STRING, TokenType::COMMA, TokenType::STRING })) {
				return failWithError("Expecting number and three string parameters", tokens.peek().pos);
			}

			const Token &str1 = tokens.ahead(1);
			const Token &str2 = tokens.ahead(3);
			const Token &str3 = tokens.ahead(5);

			std::vector<uint8_t> update;
			int wroteLines = 0;
			for (int i = 0; i < 3; ++i) {
				// Offset for the first comma, and then one more comma before each next string.
				const Token &str = tokens.ahead(1 + i * 2);
				std::vector<uint8_t> sjis;
				if (escaped_utf8_to_game_sjis(str.sval, str.slen, sjis, noPatch) == -1) {
					return failWithError("Could not encode string", str.pos);
				}
				if (sjis.size() > 16) {
					return failWithError("Line longer than 16 bytes", str.pos);
				}
				if (sjis.empty()) {
					continue;
				}

				while (wroteLines < i) {
					// The full width space separator must be aligned.
					if (update.size() & 1) {
						update.push_back(' ');
					}
					update.push_back(0x81);
					update.push_back(0x40);
					wroteLines++;
				}

				for (uint8_t c : sjis) {
					update.push_back(c);
				}
			}

			// Make sure we have an aligned double null.  Another byte is added later.
			if (update.size() & 1) {
				update.push_back(0);
			}
			update.push_back(0);

			// Skip, since we didn't consume the tokens yet.
			tokens.skip(6);
			if (!tokens.next(TokenType::END_LINE)) {
				return failWithError("Unexpected arguments", tokens.peek().pos);
			}

			uint32_t pos = table_params.ptr + args[0] * table_params.stride;
			script.inserts.push_back({ MenuInsertType::BUFFER, 0, pos, table_params.size, update, filename, command.pos });
		} else if (command.str() == "menutxtp") {
			if (!parseNumArgs(1)) {
				return false;
			}
			if (!tokens.next(TokenType::COMMA) || !tokens.peek(TokenType::STRING)) {
				return failWithError("Expecting number, string parameters", tokens.peek().pos);
			}

			const Token &str = tokens.next();
			std::vector<uint8_t> sjis;
			if (escaped_utf8_to_game_sjis(str.sval, str.slen, sjis, noPatch) == -1) {
				return failWithError("Could not encode string", str.pos);
			}

			uint32_t size = 0;
			if (tokens.ahead({ TokenType::COMMA, TokenType::NUM })) {
				tokens.skip(1);
				size = tokens.next().uval;
			}
			if (!tokens.next(TokenType::END_LINE)) {
				return failWithError("Unexpected arguments", tokens.peek().pos);
			}

			script.inserts.push_back({ MenuInsertType::RELOCATABLE_POINTER, args[0], 0, size, sjis, filename, command.pos });
		} else {
			return failWithError("Unknown command", command.pos);
		}
	}

	return true;
}

struct MenuStats {
	uint32_t updatedBytes = 0;
	uint32_t freeBytes = 0;
};

bool update_menu_script(const std::string &image, MenuScript &script, MenuStats &stats, bool noPatch) {
	std::map<std::vector<uint8_t>, uint32_t> prev;
	std::map<uint32_t, std::vector<uint8_t>> used;

	auto allocateFree = [&script](uint32_t required, uint32_t &found) -> uint32_t {
		for (auto &info : script.frees) {
			if (info.size >= required) {
				found = info.base;
				uint32_t used = (required < info.size ? required + 1 : required) & ~1;
				info.base += used;
				info.size -= used;

				return used;
			}
		}

		return 0;
	};

	std::vector<MenuInsert> extra;

	FILE *fp = fopen(image.c_str(), "rb");
	for (auto &insertion : script.inserts) {
		auto failWithError = [&](const char *message) {
			fprintf(stderr, "%s on line %u, column %u in %s\n", message, insertion.scriptpos.line, insertion.scriptpos.col, insertion.script.c_str());
			fclose(fp);
			return false;
		};

		if (insertion.type == MenuInsertType::RELOCATABLE_POINTER) {
			fseek(fp, insertion.ptr & ~0x08000000, SEEK_SET);
			if (fread(&insertion.pos, sizeof(uint32_t), 1, fp) != 1) {
				char temp[512];
				snprintf(temp, sizeof(temp), "Unable to read pointer value %08x", insertion.ptr);
				return failWithError(temp);
			}
			if (insertion.pos == 0) {
				char temp[512];
				snprintf(temp, sizeof(temp), "Null pointer value at %08x", insertion.ptr);
				return failWithError(temp);
			}
		}

		if (insertion.size == 0) {
			fseek(fp, insertion.pos & ~0x08000000, SEEK_SET);
			while (insertion.size < 32768) {
				int c = fgetc(fp);
				if (c == EOF) {
					break;
				}
				insertion.size++;
				if (c == 0) {
					break;
				}
			}
		}

		if (insertion.type == MenuInsertType::RELOCATABLE_POINTER) {
			auto usage = used.find(insertion.pos);
			if (usage != used.end()) {
				if (usage->second != insertion.update) {
					// This will cause us to relocate.
					insertion.size = 0;
				}
			}
		}

		// Account for the terminator.
		uint32_t required = (uint32_t)insertion.update.size() + 1;

		if (required > insertion.size && insertion.type == MenuInsertType::RELOCATABLE_POINTER) {
			script.frees.push_back({ insertion.pos, insertion.size });
			auto already = prev.find(insertion.update);
			if (already != prev.end()) {
				insertion.pos = already->second;
				insertion.size = required;
			}
		}

		if (required > insertion.size && insertion.type == MenuInsertType::RELOCATABLE_POINTER) {
			uint32_t allocated = allocateFree(required, insertion.pos);
			if (allocated != 0) {
				insertion.size = allocated;
				prev[insertion.update] = insertion.pos;
			}
		} else {
			// In case of re-running.
			for (auto &info : script.frees) {
				if (info.base == insertion.pos) {
					uint32_t used = (insertion.size < info.size ? insertion.size + 1 : insertion.size) & ~1;
					info.base += used;
					info.size -= used;
				}
			}

			if (required > insertion.size && insertion.size >= 6 && !noPatch) {
				uint32_t split = 0;
				// Additional 1 to account for the extra terminator.
				uint32_t allocated = allocateFree(required + 6 - insertion.size + 1, split);
				if (allocated != 0) {
					const auto slice = std::vector<uint8_t>(insertion.update.begin() + insertion.size - 6, insertion.update.end());
					script.inserts.push_back({ MenuInsertType::BUFFER, 0, split, allocated, slice, insertion.script, insertion.scriptpos });
					prev[slice] = split;

					required = insertion.size;
					insertion.update.resize(required - 1);
					insertion.update[required - 6] = 0x01;
					insertion.update[required - 5] = (split >> 0) & 0xFF;
					insertion.update[required - 4] = (split >> 8) & 0xFF;
					insertion.update[required - 3] = (split >> 16) & 0xFF;
					insertion.update[required - 2] = (split >> 24) & 0xFF;
				}
			}

			if (required + 3 < insertion.size) {
				uint32_t used = (required + 1) & ~1;
				script.frees.push_back({ insertion.pos + used, insertion.size - used });
				prev[insertion.update] = insertion.pos;
			}
		}

		if (required > insertion.size) {
			char temp[512];
			snprintf(temp, sizeof(temp), "New value too long (%u > %u)", required, insertion.size);
			return failWithError(temp);
		}

		stats.updatedBytes += required;
	}
	fclose(fp);

	for (auto &info : script.frees) {
		stats.freeBytes += info.size;
	}
	for (auto &info : extra) {
		script.inserts.push_back(info);
	}
	return true;
}

bool insert_menu_script(const std::string &image, const MenuScript &script) {
	FILE *fp = fopen(image.c_str(), "rb+");
	for (const auto &insertion : script.inserts) {
		auto failWithError = [&](const char *message) {
			fprintf(stderr, "%s on line %u, column %u in %s\n", message, insertion.scriptpos.line, insertion.scriptpos.col, insertion.script.c_str());
			fclose(fp);
			return false;
		};

		if (insertion.type == MenuInsertType::RELOCATABLE_POINTER) {
			fseek(fp, insertion.ptr & ~0x08000000, SEEK_SET);
			if (fwrite(&insertion.pos, sizeof(uint32_t), 1, fp) != 1) {
				char temp[512];
				snprintf(temp, sizeof(temp), "Unable to write pointer value to %08x", insertion.ptr);
				return failWithError(temp);
			}
		}

		fseek(fp, insertion.pos & ~0x08000000, SEEK_SET);
		if (!insertion.update.empty()) {
			if (fwrite(&insertion.update[0], insertion.update.size(), 1, fp) != 1) {
				return failWithError("Unable to write updated value");
			}
		}
		if (fputc(0, fp) == EOF) {
			return failWithError("Unable to write updated value");
		}

		if (insertion.size > insertion.update.size()) {
			size_t extra = (size_t)insertion.size - insertion.update.size() - 1;
			for (size_t i = 0; i < extra; ++i) {
				fputc(0, fp);
			}
		}
	}
	fclose(fp);
	return true;
}

int main(int argc, char *argv[]) {
	if (argc <= 1) {
		usage(stderr, argc == 0 ? "swordcraft3-main" : argv[0]);
		return 1;
	}

	Args args;
	int result = parse_args(args, argc, argv);
	if (result != 0 || args.image.empty()) {
		return result;
	}

	MenuScript menu_script;
	for (const auto &script : args.script) {
		Tokens tokens = tokenize(read_source(script));
		if (!parse_menu_script(menu_script, tokens, script, args.noPatch)) {
			return 3;
		}
	}

	MenuStats stats;
	if (!update_menu_script(args.image, menu_script, stats, args.noPatch)) {
		return 4;
	}

	if (!args.dryRun) {
		if (!insert_menu_script(args.image, menu_script)) {
			fprintf(stderr, "Insertion write failure\n");
			return 5;
		}

		if (!args.quiet) {
			printf("Inserted %u script bytes successfully\n", stats.updatedBytes);
			printf("  Menu unused: %u bytes\n", stats.freeBytes);
		}
	} else if (!args.quiet) {
		printf("No errors found\n");
		printf("  Menu insertions: %u bytes\n", stats.updatedBytes);
		printf("  Menu unused: %u bytes\n", stats.freeBytes);
	}

	return 0;
}
