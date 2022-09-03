#pragma once

#include <cstdint>
#include <string>
#include <vector>

struct Tokens;
struct TokenPos;

enum class ExpressionParse {
	AS_16BIT,
	AS_32BIT,
};

class Expression {
public:
	Expression(Tokens &t, bool useNoPatch) : tokens(t), noPatch(useNoPatch) {
	}

	bool parse(ExpressionParse type = ExpressionParse::AS_16BIT);

	const std::string &error() {
		return message;
	}

	const TokenPos &errorPos();

	std::vector<uint16_t> &&asBytecode() {
		return std::move(bytecode);
	}

	bool isConstant();
	uint32_t asConstant() const {
		return constant_;
	}

private:
	bool parseTernary();
	bool parseBaseBinary(int op);
	bool parseCompare();
	bool parseAdd();
	bool parseMul();
	bool parseUnary();
	bool parsePrimary();

	Tokens &tokens;
	bool noPatch;
	ExpressionParse parseType;
	bool lastPushed10 = false;
	uint32_t constant_ = 0xFFFFFFFF;
	std::vector<uint16_t> bytecode;
	std::string message;
	const TokenPos *messagePos = nullptr;
};
