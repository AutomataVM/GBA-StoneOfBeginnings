#include <cstdio>
#include <cstring>
#include <memory>
#include <unordered_map>
#include "expr.h"
#include "opcodes.h"
#include "parser.h"
#include "tokenizer.h"
#include "script.h"
#include "sjis.h"

class Parser {
public:
	Parser(Script &s, Tokens &t, bool np) : script(s), tokens(t), noPatch(np) {
	}

	void process();

	void parseLabelDefinition();
	void parseDirective();
	void parseCommand();
	bool parseCommandCustom(const Token &token, const Opcode &info, uint16_t code);
	bool parseExpression(Argument &arg);
	bool parseString(Argument &arg, int maxChars, int maxHalfwords);

private:
	Script &script;
	Tokens &tokens;
	bool noPatch;
	bool finished = false;
};

void Parser::process() {
	while (!finished) {
		switch (tokens.peek().type) {
		case TokenType::END_FILE:
			finished = true;
			break;

		case TokenType::END_LINE:
			tokens.next();
			break;

		case TokenType::LABEL:
			parseLabelDefinition();
			break;

		case TokenType::COMMAND:
			parseCommand();
			break;

		case TokenType::DIRECTIVE:
			parseDirective();
			break;

		default:
			script.append(std::make_unique<InvalidStatement>("Expecting command, directive, or label", tokens.peek().pos));
			finished = true;
			break;
		}
	}
}

void Parser::parseLabelDefinition() {
	const Token &label = tokens.next();
	if (tokens.next(TokenType::COLON)) {
		uint16_t id = script.findLabelID(label.str());
		script.append(std::make_unique<LabelDefinition>(id));
	} else {
		script.append(std::make_unique<InvalidStatement>("Expecting colon after label definition", tokens.peek().pos));
	}
}

void Parser::parseDirective() {
	const Token &directive = tokens.next();
	if (directive.str() == ".dh") {
		auto d = std::make_unique<DataStatement>(directive.pos);

		while (!tokens.peek(TokenType::END_LINE)) {
			const Token &value = tokens.next();
			if (value.type == TokenType::NUM) {
				if (value.uval & 0xFFFF0000) {
					script.append(std::make_unique<InvalidStatement>(".dh argument overflow", value.pos));
					break;
				}
				d->addHalfword(value.uval);
			} else if (value.type == TokenType::LABEL) {
				uint16_t id = script.findLabelID(value.str());
				d->addLabel(id);
			} else {
				script.append(std::make_unique<InvalidStatement>(".dh can only take numbers and labels", value.pos));
				break;
			}

			if (!tokens.next(TokenType::COMMA)) {
				break;
			}
		}

		if (!tokens.next(TokenType::END_LINE) && !tokens.peek(TokenType::END_FILE)) {
			script.append(std::make_unique<InvalidStatement>(".dh can only take numbers and labels", tokens.peek().pos));
		}
		
		script.append(std::move(d));
		return;
	} else {
		script.append(std::make_unique<InvalidStatement>("Unsupported directive", directive.pos));
	}
}

void Parser::parseCommand() {
	const Token &command = tokens.next();
	auto it = oplookup.find(command.str());
	if (it == oplookup.end()) {
		script.append(std::make_unique<InvalidStatement>("Unknown command", command.pos));
		return;
	}

	const uint16_t code = it->second;
	const Opcode &info = optable[code >> 8][code & 0xFF];
	if (info.flags & OpcodeFlags::INVALID) {
		script.append(std::make_unique<InvalidStatement>("Invalid command", command.pos));
		return;
	}

	if (info.flags & OpcodeFlags::HAS_PARSE) {
		if (parseCommandCustom(command, info, code)) {
			return;
		}
	}

	std::vector<Argument> args;
	args.resize(strlen(info.args));
	for (size_t i = 0; i < args.size(); ++i) {
		if (i != 0 && !tokens.next(TokenType::COMMA)) {
			script.append(std::make_unique<InvalidStatement>("Insufficient arguments for command", command.pos));
			return;
		}

		if (info.args[i] == 's') {
			if (!parseString(args[i], info.string_char_max, info.string_half_max)) {
				return;
			}
		} else if (info.args[i] == 'e') {
			if (!parseExpression(args[i])) {
				return;
			}
		} else if (info.args[i] == 'l') {
			if (!tokens.peek(TokenType::LABEL)) {
				script.append(std::make_unique<InvalidStatement>("Expecting label argument", tokens.peek().pos));
				return;
			}

			const Token &label = tokens.next();
			uint16_t id = script.findLabelID(label.str());
			args[i] = Argument::Label(id);
		} else if (info.args[i] == 'h') {
			if (!tokens.peek(TokenType::NUM)) {
				script.append(std::make_unique<InvalidStatement>("Expecting number argument", tokens.peek().pos));
				return;
			}

			const Token &value = tokens.next();
			if (value.uval & 0xFFFF0000) {
				script.append(std::make_unique<InvalidStatement>("Comand argument overflow", value.pos));
				return;
			}

			args[i] = Argument::Halfword(value.uval);
		} else {
			script.append(std::make_unique<InvalidStatement>("Unexpected argument type", tokens.peek().pos));
			return;
		}
	}

	if (!tokens.next(TokenType::END_LINE) && !tokens.peek(TokenType::END_FILE)) {
		script.append(std::make_unique<InvalidStatement>("Too many arguments for command", command.pos));
		return;
	}

	script.append(std::make_unique<CommandStatement>(info, code, std::move(args), command.pos));
}

bool Parser::parseCommandCustom(const Token &token, const Opcode &info, uint16_t code) {
	if (code == 0x0001 && tokens.ahead({ TokenType::VAR, TokenType::COMMA })) {
		const Token &shorthand = tokens.next();
		std::vector<Argument> args;
		args.resize(strlen(info.args));
		args[0] = Argument::Halfword(shorthand.vtype);
		args[1] = Argument::Halfword(shorthand.vindex);
		// Skip the comma.
		tokens.next();
		if (parseExpression(args[2])) {
			script.append(std::make_unique<CommandStatement>(info, code, std::move(args), token.pos));
		}
		return true;
	}

	if (code == 0x0462) {
		size_t resetPos = tokens.pos;
		std::vector<Argument> args;
		args.resize(strlen(info.args));
		if (!parseExpression(args[0])) {
			// If that errored, we "parsed" this so return true.
			return true;
		}

		if (!tokens.next(TokenType::COMMA) || !tokens.peek(TokenType::L_PAREN)) {
			// Okay, wrong format.  Hit the undo button and reparse that first expression.
			tokens.pos = resetPos;
			return false;
		}

		auto parseXY = [&](int base) {
			if (!tokens.next(TokenType::L_PAREN)) {
				script.append(std::make_unique<InvalidStatement>("Expected left parenthesis before X, Y pair", tokens.peek().pos));
				return false;
			}
			if (!parseExpression(args[base + 0])) {
				return false;
			}
			if (!tokens.next(TokenType::COMMA)) {
				script.append(std::make_unique<InvalidStatement>("Expected comma between X, Y pair", tokens.peek().pos));
				return false;
			}
			if (!parseExpression(args[base + 1])) {
				return false;
			}
			if (!tokens.next(TokenType::R_PAREN)) {
				script.append(std::make_unique<InvalidStatement>("Expected right parenthesis before X, Y pair", tokens.peek().pos));
				return false;
			}
			return true;
		};

		if (!parseXY(1)) {
			// We added an error, so we parsed it.
			return true;
		}
		if (!tokens.next(TokenType::SUB)) {
			script.append(std::make_unique<InvalidStatement>("Expected hyphen between X, Y pairs", tokens.peek().pos));
			return false;
		}
		if (parseXY(3)) {
			script.append(std::make_unique<CommandStatement>(info, code, std::move(args), token.pos));
		}
		return true;
	}

	return false;
}

bool Parser::parseExpression(Argument &arg) {
	arg.type = ArgumentType::EXPRESSION;
	Expression expr(tokens, noPatch);

	if (expr.parse()) {
		arg.value = expr.asBytecode();
		return true;
	}

	script.append(std::make_unique<InvalidStatement>(expr.error(), expr.errorPos()));
	return false;
}

bool Parser::parseString(Argument &arg, int maxChars, int maxHalfwords) {
	if (!tokens.peek(TokenType::STRING)) {
		script.append(std::make_unique<InvalidStatement>("Expected string argument", tokens.peek().pos));
		return false;
	}

	const Token &tok = tokens.next();
	std::vector<uint8_t> sjis;
	int chars = escaped_utf8_to_game_sjis(tok.sval, tok.slen, sjis, noPatch);
	if (chars < 0) {
		script.append(std::make_unique<InvalidStatement>("Unable to process string, invalid characters", tok.pos));
		return false;
	}
	if (chars > maxChars && maxChars != 0) {
		std::string message;
		message.resize(1024);
		message.resize(snprintf(&message[0], message.size(), "String argument cannot be more than %d characters long, %d provided", maxChars, chars));
		script.append(std::make_unique<InvalidStatement>(message, tok.pos));
		return false;
	}

	if (sjis.size() & 1) {
		// Need an aligned 0.
		sjis.resize(sjis.size() + 3);
	} else {
		sjis.resize(sjis.size() + 2);
	}

	int halfwords = (int)sjis.size() / 2;
	if (halfwords > maxHalfwords && maxHalfwords != 0) {
		std::string message;
		message.resize(1024);
		message.resize(snprintf(&message[0], message.size(), "String argument is %d halfwords long, cannot exceed %d", halfwords, maxHalfwords));
		script.append(std::make_unique<InvalidStatement>(message, tok.pos));
		return false;
	}

	arg.type = ArgumentType::STRING;
	arg.value.resize(halfwords);
	for (size_t i = 0; i < sjis.size(); i += 2) {
		arg.value[i / 2] = (sjis[i + 1] << 8) | sjis[i];
	}
	return true;
}

Script parse_script(Tokens &tokens, bool noPatch) {
	Script script;
	Parser(script, tokens, noPatch).process();
	return script;
}
