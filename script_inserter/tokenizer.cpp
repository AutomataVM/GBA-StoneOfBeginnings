#include <cctype>
#include "tokenizer.h"

class Tokenizer {
public:
	Tokenizer(Tokens &t) : tokens(t) {
	}

	void process();

private:
	void append(TokenType t, size_t l);
	void appendStr(TokenType t, const char *s, int l);
	void appendNum(uint32_t v, size_t l);
	void appendVar(uint16_t t, uint16_t i, size_t l);
	TokenPos currentPos() {
		return TokenPos{ line, (uint32_t)(1 + pos - lastLine) };
	}

	char peek(size_t off = 0) {
		return pos + off < tokens.src.size() ? tokens.src[pos + off] : '\0';
	}

	void eatWhite();
	void eatLineComment();
	void eatBlockComment();

	void readVar();
	void readLabel();
	void readDirective();
	void readCommand();
	void readString();
	void readNum();

	Tokens &tokens;
	size_t pos = 0;
	uint32_t line = 1;
	size_t lastLine = 0;
};

void Tokenizer::process() {
	// Skip any BOM.
	if (tokens.src.size() >= 3 && (uint8_t)tokens.src[0] == 0xEF && (uint8_t)tokens.src[1] == 0xBB && (uint8_t)tokens.src[2] == 0xBF) {
		pos += 3;
	}

	eatWhite();
	while (pos < tokens.src.size()) {
		char c = tokens.src[pos];
		switch (c) {
		case '\r':
			if (peek(1) == '\n') {
				append(TokenType::END_LINE, 2);
			} else {
				append(TokenType::END_LINE, 1);
			}
			break;
		case '\n':
			append(TokenType::END_LINE, 1);
			break;

		case ';':
			eatLineComment();
			break;
		case '/':
			if (peek(1) == '/') {
				eatLineComment();
			} else if (peek(1) == '*') {
				eatBlockComment();
			} else {
				append(TokenType::DIV, 1);
			}
			break;

		case '%':
			append(TokenType::MOD, 1);
			break;

		case '*':
			append(TokenType::MUL, 1);
			break;

		case '+':
			append(TokenType::ADD, 1);
			break;

		case '-':
			append(TokenType::SUB, 1);
			break;

		case '?':
			append(TokenType::QUESTION, 1);
			break;

		case ':':
			append(TokenType::COLON, 1);
			break;

		case '~':
			append(TokenType::BIT_NOT, 1);
			break;

		case '!':
			if (peek(1) == '=') {
				append(TokenType::CMP_NE, 2);
			} else {
				append(TokenType::BOOL_NOT, 1);
			}			
			break;

		case '(':
			append(TokenType::L_PAREN, 1);
			break;

		case ')':
			append(TokenType::R_PAREN, 1);
			break;

		case ',':
			append(TokenType::COMMA, 1);
			break;

		case '<':
			if (peek(1) == '=') {
				append(TokenType::CMP_LE, 2);
			} else {
				append(TokenType::CMP_LT, 1);
			}
			break;

		case '>':
			if (peek(1) == '=') {
				append(TokenType::CMP_GE, 2);
			} else {
				append(TokenType::CMP_GT, 1);
			}
			break;

		case '=':
			if (peek(1) == '=') {
				append(TokenType::CMP_EQ, 2);
			} else {
				appendStr(TokenType::INVALID, "Unexpected '=', did you mean '=='?", 1);
			}
			break;

		case '&':
			if (peek(1) == '&') {
				append(TokenType::BOOL_AND, 2);
			} else {
				append(TokenType::BIT_AND, 1);
			}
			break;

		case '|':
			if (peek(1) == '|') {
				append(TokenType::BOOL_OR, 2);
			} else {
				append(TokenType::BIT_OR, 1);
			}
			break;

		case '^':
			append(TokenType::BIT_XOR, 1);
			break;

		case '$':
			readVar();
			break;

		case '@':
			readLabel();
			break;

		case '.':
			readDirective();
			break;

		case '"':
			readString();
			break;

		default:
			if (isdigit((uint8_t)c)) {
				readNum();
			} else if (isalpha((uint8_t)c)) {
				readCommand();
			} else {
				appendStr(TokenType::INVALID, "Unexpected character in input", 1);
			}
			break;
		}
		eatWhite();
	}

	append(TokenType::END_FILE, 0);
}

void Tokenizer::append(TokenType t, size_t l) {
	tokens.stack.emplace_back(Token{ t, currentPos() });
	pos += l;
	if (t == TokenType::END_LINE) {
		lastLine = pos;
		line++;
	}
}

void Tokenizer::appendStr(TokenType t, const char *s, int l) {
	tokens.stack.emplace_back(Token{ t, currentPos() });
	tokens.stack.back().sval = s;
	tokens.stack.back().slen = l;
	pos += l;
}

void Tokenizer::appendNum(uint32_t v, size_t l) {
	tokens.stack.emplace_back(Token{ TokenType::NUM, currentPos() });
	tokens.stack.back().uval = v;
	pos += l;
}

void Tokenizer::appendVar(uint16_t t, uint16_t i, size_t l) {
	tokens.stack.emplace_back(Token{ TokenType::VAR, currentPos() });
	tokens.stack.back().vtype = t;
	tokens.stack.back().vindex = i;
	pos += l;
}

void Tokenizer::eatWhite() {
	while (pos < tokens.src.size()) {
		switch (tokens.src[pos]) {
		case '\t':
		case ' ':
		case '\v':
		case '\f':
			pos++;
			break;

		default:
			return;
		}
	}
}

void Tokenizer::eatLineComment() {
	// Consume the starting char.
	pos++;
	while (pos < tokens.src.size()) {
		switch (tokens.src[pos]) {
		case '\r':
			if (peek(1) == '\n') {
				append(TokenType::END_LINE, 2);
			} else {
				append(TokenType::END_LINE, 1);
			}
			return;
		case '\n':
			append(TokenType::END_LINE, 1);
			return;

		default:
			pos++;
			break;
		}
	}
}

void Tokenizer::eatBlockComment() {
	// Consume the "/*".
	pos += 2;

	while (pos < tokens.src.size()) {
		switch (tokens.src[pos]) {
		case '\r':
			if (peek(1) == '\n') {
				append(TokenType::END_LINE, 2);
			} else {
				append(TokenType::END_LINE, 1);
			}
			break;
		case '\n':
			append(TokenType::END_LINE, 1);
			break;

		case '*':
			if (peek(1) == '/') {
				// Okay, we hit the "*/".
				pos += 2;
				return;
			} else {
				pos++;
			}
			break;

		default:
			pos++;
			break;
		}
	}

	appendStr(TokenType::INVALID, "Unterminated block comment, expecting '*/'", 1);
}

void Tokenizer::readVar() {
	uint16_t vtype = 0;
	uint16_t voffset = 0;
	// After adding voffset.
	uint16_t vmax = 0;
	int numoff = 2;

	if (peek(1) == 'w') {
		vtype = 2;
		voffset = 0;
		vmax = 0x003F;
	} else if (peek(1) == 'f') {
		vtype = 3;
		voffset = 0x0100;
		// TODO: Not sure what the max is.
		vmax = 0xFFFF;
	} else if (peek(1) == 'h') {
		if (peek(2) == 'v') {
			numoff = 3;
			vtype = 3;
			voffset = 0;
			vmax = 0x001F;
		} else {
			vtype = 2;
			voffset = 0x0040;
			vmax = 0x017F;
		}
	} else if (peek(1) == 'b') {
		if (peek(2) == 'v') {
			numoff = 3;
			vtype = 3;
			voffset = 0x0020;
			vmax = 0x00FF;
		} else {
			vtype = 2;
			voffset = 0x0180;
			// TODO: Not sure what the max is.
			vmax = 0xFFFF;
		}
	} else {
		numoff = 1;
	}

	if (!isdigit((uint8_t)peek(numoff)) || vtype == 0) {
		appendStr(TokenType::INVALID, "Found '$' without a valid variable reference, expecting similar to $w0, $f0, $h0, $hv0, $b0, $bv0", numoff);
		return;
	}

	uint32_t vindex = 0;
	while (isdigit((uint8_t)peek(numoff))) {
		if (vindex <= 0xFFFF) {
			vindex = vindex * 10 + peek(numoff) - '0';
		}
		numoff++;
	}
	vindex += voffset;

	if (vindex > vmax) {
		appendStr(TokenType::INVALID, "Variable doesn't exist, number too high", numoff);
		return;
	}

	appendVar(vtype, vindex, numoff);
}

static bool isLabelChar(char c) {
	if (isalnum((uint8_t)c)) {
		return true;
	}
	return c == '_';
}

void Tokenizer::readLabel() {
	int off = 1;
	while (isLabelChar(peek(off))) {
		off++;
	}
	if (off == 1) {
		appendStr(TokenType::INVALID, "Incomplete label name, found only '@'", 1);
	} else {
		appendStr(TokenType::LABEL, &tokens.src[pos], off);
	}
}

void Tokenizer::readDirective() {
	int off = 1;
	while (isalpha((uint8_t)peek(off))) {
		off++;
	}
	if (off == 1) {
		appendStr(TokenType::INVALID, "Incomplete directive, found only '.'", 1);
	} else {
		appendStr(TokenType::DIRECTIVE, &tokens.src[pos], off);
	}
}

void Tokenizer::readCommand() {
	int off = 1;
	while (isalnum((uint8_t)peek(off))) {
		off++;
	}
	appendStr(TokenType::COMMAND, &tokens.src[pos], off);
}

void Tokenizer::readString() {
	int len = 1;
	while (pos + len < tokens.src.size()) {
		switch (tokens.src[pos + len]) {
		case '\r':
		case '\n':
			appendStr(TokenType::INVALID, "Unterminated string - multiline strings are not supported", len);
			return;

		case '\\':
			switch (peek(len + 1)) {
			case '\0':
				appendStr(TokenType::INVALID, "Unterminated string - missing character after escape", len + 1);
				return;

			case '\r':
			case '\n':
				appendStr(TokenType::INVALID, "Unterminated string - multiline strings are not supported", len + 1);
				return;

			default:
				len += 2;
				break;
			}
			break;

		case '"':
			appendStr(TokenType::STRING, &tokens.src[pos], len + 1);
			return;

		default:
			len++;
			break;
		}
	}

	appendStr(TokenType::INVALID, "Unterminated string - hit end of file", len);
}

void Tokenizer::readNum() {
	if (peek(0) == '0' && peek(1) == 'x') {
		size_t numoff = 2;
		uint32_t v = 0;
		while (isalnum((uint8_t)peek(numoff))) {
			char c = peek(numoff);
			if (c >= '0' && c <= '9') {
				v = (v << 4) | (c - '0');
			} else if (c >= 'a' && c <= 'f') {
				v = (v << 4) | (c - 'a' + 10);
			} else if (c >= 'A' && c <= 'F') {
				v = (v << 4) | (c - 'A' + 10);
			} else {
				break;
			}
			numoff++;
		}
		appendNum(v, numoff);
	} else {
		size_t numoff = 0;
		uint32_t v = 0;
		while (isdigit((uint8_t)peek(numoff))) {
			v = v * 10 + peek(numoff) - '0';
			numoff++;
		}
		appendNum(v, numoff);
	}

}

Tokens tokenize(const std::string &source) {
	Tokens tokens(source);
	Tokenizer(tokens).process();
	return tokens;
}
