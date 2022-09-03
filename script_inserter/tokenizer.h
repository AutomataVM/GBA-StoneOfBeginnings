#pragma once

#include <cstdint>
#include <string>
#include <vector>

enum class TokenType {
	INVALID,
	COMMAND,
	DIRECTIVE,
	NUM,
	LABEL,
	STRING,
	COMMA,
	VAR,
	L_PAREN,
	R_PAREN,
	BIT_NOT,
	BOOL_NOT,
	MUL,
	DIV,
	MOD,
	ADD,
	SUB,
	QUESTION,
	COLON,
	CMP_LT,
	CMP_LE,
	CMP_GT,
	CMP_GE,
	CMP_EQ,
	CMP_NE,
	BIT_AND,
	BIT_OR,
	BIT_XOR,
	BOOL_AND,
	BOOL_OR,
	END_LINE,
	END_FILE,
};

struct TokenPos {
	uint32_t line;
	uint32_t col;
};

struct Token {
	TokenType type;
	TokenPos pos;

	inline std::string str() const {
		switch (type) {
		case TokenType::INVALID:
			return sval;

		case TokenType::LABEL:
		case TokenType::DIRECTIVE:
		case TokenType::COMMAND:
		case TokenType::STRING:
			return std::string(sval, slen);

		default:
			return "";
		}
	}

	union {
		uint32_t uval;
		struct {
			int slen;
			const char *sval;
		};
		struct {
			uint16_t vtype;
			uint16_t vindex;
		};
	};
};

struct Tokens {
	Tokens(const std::string &source) {
		src = source;
	}

	const Token &peek() const {
		return stack[pos];
	}
	const Token &next() {
		return stack[pos++];
	}
	const Token &ahead(int off) const {
		return stack[pos + off];
	}
	void skip(int off) {
		pos += off;
	}

	bool peek(TokenType t) const {
		return stack[pos].type == t;
	}
	bool next(TokenType t) {
		if (peek(t)) {
			pos++;
			return true;
		}
		return false;
	}
	bool ahead(const std::vector<TokenType> &types) const {
		size_t p = pos;
		for (const TokenType &t : types) {
			if (stack[p++].type != t) {
				return false;
			}
		}
		return true;
	}

	std::vector<Token> stack;
	size_t pos = 0;
	// Referenced by pointers.
	std::string src;
};

Tokens tokenize(const std::string &source);
