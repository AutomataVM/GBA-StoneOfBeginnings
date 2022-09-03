#include <unordered_map>
#include "expr.h"
#include "tokenizer.h"

bool Expression::parse(ExpressionParse type) {
	parseType = type;
	lastPushed10 = false;
	if (parseTernary()) {
		if (!noPatch && bytecode.size() == 2 && bytecode[0] == 0x0001 && bytecode[1] <= 0x00FF) {
			uint8_t v = bytecode[1] & 0xFF;
			bytecode.clear();
			bytecode.push_back(0x0300 | v);
		} else if (!noPatch && bytecode.size() == 1 && (bytecode[0] & 0xFF00) == 0x0100) {
			bytecode[0] |= 0x0300;
		} else {
			// End of expression.
			bytecode.push_back(0);
		}
		return true;
	}
	return false;
}

const TokenPos &Expression::errorPos() {
	return messagePos ? *messagePos : tokens.peek().pos;
}

bool Expression::isConstant() {
	// Direct constant, optimize immediately.
	if (!noPatch && bytecode.size() == 1 && (bytecode[0] & 0xFD00) == 0x0100) {
		constant_ = bytecode[0] & 0x00FF;
		return true;
	} else if (bytecode.size() == 3 && bytecode[0] == 0x0001 && bytecode[2] == 0) {
		constant_ = bytecode[1];
		return true;
	}

	std::vector<int32_t> stack;
	for (size_t i = 0; i < bytecode.size(); ++i) {
		if (bytecode[i] == 0x000) {
			break;
		} else if (bytecode[i] == 0x0001) {
			stack.push_back((int32_t)(int16_t)bytecode[++i]);
			continue;
		} else if (bytecode[i] == 0x0002 || bytecode[i] == 0x0003) {
			// Variable reference, not a constant expression.
			return false;
		} else if (bytecode[i] == 0x0004 && parseType == ExpressionParse::AS_32BIT) {
			// Internal use only.
			uint16_t low = bytecode[++i];
			stack.push_back(low | (bytecode[++i] << 16));
			continue;
		} else if (bytecode[i] == 0x0080 && stack.size() >= 1) {
			stack.back() = stack.back() == 0 ? 1 : 0;
			continue;
		} else if (bytecode[i] == 0x0081 && stack.size() >= 1) {
			stack.back() = ~stack.back();
			continue;
		} else if ((bytecode[i] & 0xFF00) == 0x0100) {
			stack.push_back(bytecode[i] & 0x00FF);
			continue;
		} else if ((bytecode[i] & 0xFF00) == 0x0300) {
			constant_ = bytecode[i] & 0x00FF;
			return true;
		}

		if (stack.size() < 2) {
			// Bad encoding.
			return false;
		}

		int32_t b = (int32_t)stack.back();
		stack.pop_back();
		int32_t a = (int32_t)stack.back();
		stack.pop_back();

		switch (bytecode[i]) {
		case 0x0082:
			stack.push_back((int32_t)(a * b));
			break;

		case 0x0083:
			stack.push_back(b == 0 ? 0 : (a / b));
			break;

		case 0x0084:
			stack.push_back(b == 0 ? 0 : (a % b));
			break;

		case 0x0085:
			stack.push_back(a + b);
			break;

		case 0x0086:
			stack.push_back(a - b);
			break;

		case 0x0087:
			stack.push_back(a < b ? 1 : 0);
			break;

		case 0x0088:
			stack.push_back(a <= b ? 1 : 0);
			break;

		case 0x0089:
			stack.push_back(a > b ? 1 : 0);
			break;

		case 0x008A:
			stack.push_back(a >= b ? 1 : 0);
			break;

		case 0x008B:
			stack.push_back(a == b ? 1 : 0);
			break;

		case 0x008C:
			stack.push_back(a != b ? 1 : 0);
			break;

		case 0x008D:
			stack.push_back(a & b);
			break;

		case 0x008E:
			stack.push_back(a ^ b);
			break;

		case 0x008F:
			stack.push_back(a | b);
			break;

		case 0x0090:
			stack.push_back((a & b) != 0 ? 1 : 0);
			break;

		case 0x0091:
			stack.push_back((a | b) != 0 ? 1 : 0);
			break;

		default:
			// Unknown encoding.
			return false;
		}
	}

	// Did we end up with a constant?
	if (stack.size() == 1) {
		constant_ = (uint32_t)stack[0];
		return true;
	}
	// Bad encoding?
	return false;
}

bool Expression::parseTernary() {
	if (!parseBaseBinary(0)) {
		return false;
	}
	if (tokens.next(TokenType::QUESTION)) {
		// Can only really do ? 1 : 0 or ? 0 : 1.
		if (tokens.ahead({ TokenType::NUM, TokenType::COLON, TokenType::NUM })) {
			int yes = tokens.ahead(0).uval;
			int no = tokens.ahead(2).uval;
			if (yes == 1 && no == 0) {
				// Force to 1/0.
				if (!lastPushed10) {
					bytecode.push_back(0x0080);
					bytecode.push_back(0x0080);
				}
			} else if (yes == 0 && no == 1) {
				bytecode.push_back(0x0080);
			} else {
				message = "Invalid expression, can only have x ? 1 : 0 or ? 0 : 1";
				return false;
			}
			lastPushed10 = true;
			tokens.skip(3);
		} else {
			message = "Invalid expression, can only have x ? 1 : 0 or ? 0 : 1";
			return false;
		}
	}

	return true;
}

bool Expression::parseBaseBinary(int op) {
	if (op >= 5) {
		return parseCompare();
	}

	// Levels of precedence.
	TokenType hierarchy[]{ TokenType::BOOL_OR, TokenType::BOOL_AND, TokenType::BIT_OR, TokenType::BIT_XOR, TokenType::BIT_AND, TokenType::CMP_EQ };
	uint16_t codes[]{ 0x91, 0x90, 0x8F, 0x0E, 0x8D };

	if (!parseBaseBinary(op + 1)) {
		return false;
	}
	while (tokens.next(hierarchy[op])) {
		if (!parseBaseBinary(op + 1)) {
			message = "Expected expression after binary operator";
			return false;
		}
		bytecode.push_back(codes[op]);
		lastPushed10 = op < 2;
	}
	return true;
}

bool Expression::parseCompare() {
	static const std::unordered_map<TokenType, uint16_t> ops = {
		{ TokenType::CMP_NE, 0x8C },
		{ TokenType::CMP_EQ, 0x8B },
		{ TokenType::CMP_GE, 0x8A },
		{ TokenType::CMP_GT, 0x89 },
		{ TokenType::CMP_LE, 0x88 },
		{ TokenType::CMP_LT, 0x87 },
	};

	if (!parseAdd()) {
		return false;
	}
	if (ops.find(tokens.peek().type) != ops.end()) {
		uint16_t code = ops.at(tokens.next().type);
		if (!parseAdd()) {
			message = "Expected expression after compare operator";
			return false;
		}
		bytecode.push_back(code);
		lastPushed10 = true;
	}

	return true;
}

bool Expression::parseAdd() {
	if (!parseMul()) {
		return false;
	}
	while (tokens.peek(TokenType::ADD) || tokens.peek(TokenType::SUB)) {
		bool add = tokens.next().type == TokenType::ADD;
		if (!parseMul()) {
			message = "Expected expression after add/sub operator";
			return false;
		}
		bytecode.push_back(add ? 0x85 : 0x86);
		lastPushed10 = false;
	}

	return true;
}

bool Expression::parseMul() {
	static const std::unordered_map<TokenType, uint16_t> ops = {
		{ TokenType::MUL, 0x82 },
		{ TokenType::DIV, 0x83 },
		{ TokenType::MOD, 0x84 },
	};

	if (!parseUnary()) {
		return false;
	}
	while (ops.find(tokens.peek().type) != ops.end()) {
		uint16_t code = ops.at(tokens.next().type);
		if (!parseUnary()) {
			message = "Expected expression after mul/div/mod operator";
			return false;
		}
		bytecode.push_back(code);
		lastPushed10 = false;
	}

	return true;
}

bool Expression::parseUnary() {
	static const std::unordered_map<TokenType, uint16_t> ops = {
		{ TokenType::BOOL_NOT, 0x80 },
		{ TokenType::BIT_NOT, 0x81 },
		{ TokenType::ADD, 0 },
		{ TokenType::SUB, 1 },
	};

	if (ops.find(tokens.peek().type) != ops.end()) {
		uint16_t code = ops.at(tokens.next().type);
		size_t argpos = bytecode.size();
		if (!parseUnary()) {
			message = "Expected expression after unary operator";
			return false;
		}

		if (code == 0) {
			// + does nothing, might just be +1 to align with a -1.
		} else if (code == 1) {
			// - can negate a constant, otherwise we'll need to splice in a 0.
			if (argpos + 2 == bytecode.size() && bytecode[argpos] == 0x0001) {
				// We added only a constant, so just negate it.
				bytecode[argpos + 1] = (uint16_t)-(int16_t)bytecode[argpos + 1];
			} else if (!noPatch && argpos + 1 == bytecode.size() && (bytecode[argpos] & 0xFF00) == 0x0100) {
				// We added only a constant, expand so we can negate.  Faster in the code than a sub.
				int16_t v = bytecode[argpos] & 0x00FF;
				bytecode[argpos] = 0x0001;
				bytecode.push_back((uint16_t)-v);
			} else {
				// Insert a 0 before the new value on the stack.
				if (noPatch) {
					bytecode.insert(bytecode.begin() + argpos, { 0x0001, 0x0000 });
				} else {
					bytecode.insert(bytecode.begin() + argpos, 0x0100);
				}
				// Now subtract.
				bytecode.push_back(0x0086);
			}
			lastPushed10 = false;
		} else {
			// Otherwise, just a code to add.
			bytecode.push_back(code);
			lastPushed10 = false;
		}

		return true;
	}

	return parsePrimary();
}

bool Expression::parsePrimary() {
	if (tokens.next(TokenType::L_PAREN)) {
		// Recursive descent, ahoy.
		if (!parseTernary()) {
			return false;
		}
		if (!tokens.next(TokenType::R_PAREN)) {
			message = "Invalid expression, missing right parenthesis";
			return false;
		}
		return true;
	}

	if (tokens.peek(TokenType::NUM)) {
		const Token &value = tokens.next();
		if (value.uval & 0xFFFF0000) {
			if (parseType != ExpressionParse::AS_32BIT) {
				message = "Expression literal overflow";
				messagePos = &value.pos;
				return false;
			}

			// Not actually supported by the game, just internal usage.
			bytecode.push_back(0x0004);
			bytecode.push_back(value.uval & 0x0000FFFF);
			bytecode.push_back(value.uval >> 16);
			lastPushed10 = false;
			return true;
		}

		if (!noPatch && value.uval <= 0xFF) {
			bytecode.push_back(0x0100 | value.uval);
		} else {
			bytecode.push_back(0x0001);
			bytecode.push_back(value.uval);
		}
		lastPushed10 = value.uval == 0 || value.uval == 1;
		return true;
	}

	if (tokens.peek(TokenType::VAR)) {
		const Token &value = tokens.next();

		bytecode.push_back(value.vtype);
		bytecode.push_back(value.vindex);
		lastPushed10 = value.vtype == 3 && value.vindex >= 0x100;
		return true;
	}

	message = "Expecting number, variable, or subexpression";
	return false;
}
