#include <cstdio>
#include <cstring>
#include <string>
#include "inserter.h"
#include "parser.h"
#include "tokenizer.h"

static void usage(FILE *out, const char *argv0) {
	fprintf(out, "Usage: %s [--args] image.gba script.txt\n", argv0);
	fprintf(out, "\n");
	fprintf(out, "   --pos=HEX       Where to insert the new script\n");
	fprintf(out, "   --dry-run       Test insertion only, don't modify image\n");
	fprintf(out, "   --no-patch      Use only encodings supported unpatched\n");
	fprintf(out, "   --quiet         Output only errors\n");
}

struct Args {
	std::string image;
	std::string script;
	uint32_t pos = 0;
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
			if (!strncmp(argv[i], "--pos=", 6)) {
				result.pos = (uint32_t)strtoul(argv[i] + 6, nullptr, 16);
			} else if (!strcmp(argv[i], "--pos") && i + 1 < argc) {
				result.pos = (uint32_t)strtoul(argv[++i], nullptr, 16);
			} else if (!strcmp(argv[i], "--dry-run")) {
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
		} else if (result.script.empty()) {
			result.script = argv[i];
		} else {
			usage(stderr, argv[0]);
			fprintf(stderr, "\nERROR: Too many parameters: %s\n", argv[i]);
			return 1;
		}
	}

	if (result.image.empty() || result.script.empty() || result.pos == 0) {
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

	fp = fopen(result.script.c_str(), "rb");
	if (!fp) {
		usage(stderr, argv[0]);
		fprintf(stderr, "\nERROR: Could not open file: %s", result.script.c_str());
		return 2;
	}
	fclose(fp);

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

int compile_script(const std::string &filename, std::vector<uint8_t> &out, bool noPatch) {
	Tokens tokens = tokenize(read_source(filename));
	Script script = parse_script(tokens, noPatch);

	std::vector<std::string> errors;
	if (!script.validate(errors)) {
		fprintf(stderr, "Invalid script source file %s\n", filename.c_str());
		for (const auto &error : errors) {
			fprintf(stderr, "%s\n", error.c_str());
		}
		return 3;
	}

	out = script.encode();
	return 0;
}

int main(int argc, char *argv[]) {
	if (argc <= 1) {
		usage(stderr, argc == 0 ? "swordcraftc" : argv[0]);
		return 1;
	}

	Args args;
	int result = parse_args(args, argc, argv);
	if (result != 0 || args.image.empty()) {
		return result;
	}

	std::vector<uint8_t> out;
	result = compile_script(args.script, out, args.noPatch);
	if (result != 0) {
		return result;
	}

	InsertInfo info = detect_insert_info(args.image, args.pos);
	std::vector<uint8_t> data = prepare_insert(out, info);
	if (!info.valid) {
		fprintf(stderr, "Insertion failed: %s\n", info.error.c_str());
		return 4;
	}
	if (!args.dryRun) {
		if (!insert_script_data(args.image, data, info)) {
			fprintf(stderr, "Insertion write failure\n");
			return 5;
		}

		if (!args.quiet) {
			printf("Inserted %u script bytes successfully\n", (uint32_t)data.size());
		}
	} else if (!args.quiet) {
		printf("No errors found\n");
		printf("  Script size: %u bytes => %u bytes\n", info.prev_size, (uint32_t)out.size());
		if (info.compressed) {
			printf("  Compressed: %u bytes => %u bytes\n", info.space_avail, (uint32_t)data.size());
		} else {
			printf("  Available insert space: %u\n", info.space_avail);
		}
	}

	return 0;
}
