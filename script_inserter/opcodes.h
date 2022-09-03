#pragma once

#include <cstdint>
#include <string>
#include <unordered_map>

enum class OpcodeFlags {
	NORMAL = 0x0000,
	END = 0x0001,
	HAS_PARSE = 0x0002,
	INVALID = 0x8000,
};
static inline OpcodeFlags operator |(const OpcodeFlags &lhs, const OpcodeFlags &rhs) {
	return OpcodeFlags((int)lhs | (int)rhs);
}
static inline bool operator &(const OpcodeFlags &lhs, const OpcodeFlags &rhs) {
	return ((int)lhs & (int)rhs) != 0;
}

struct Opcode {
	const char *args;
	const char *alias;
	OpcodeFlags flags;
	int string_char_max;
	int string_half_max;
};

extern const Opcode optable[5][0x100];
extern std::unordered_map<std::string, uint16_t> oplookup;
