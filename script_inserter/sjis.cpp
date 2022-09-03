#include <cctype>
#include <cstring>
#include "sjis.h"
#include "sjis_table.h"

static const int8_t ascii_valid[0x80] = {
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
};

static bool parse_control_code(const char *str, size_t len, uint32_t *val, size_t *pos, bool noPatch) {
	int num = 0;
	int maxnum = 0;
	size_t start = 0;
	uint16_t code = 0;

	if (!noPatch && len >= 9 && (!strncmp(str, "[WIDTH=", strlen("[WIDTH=")) || !strncmp(str, "[WIDTH ", strlen("[WIDTH ")))) {
		if (!strncmp(str, "[WIDTH RESET]", strlen("[WIDTH RESET]"))) {
			*val = 0xFF7F;
			*pos += strlen("[WIDTH RESET]") - 1;
			return true;
		}
		maxnum = 255;
		start = strlen("[WIDTH=");
		code = 0x007F;
	} else if (len >= 8 && !strncmp(str, "[NAME ", strlen("[NAME "))) {
		maxnum = 15;
		start = strlen("[NAME ");
		code = 0xC083;
	} else if (len >= 7 && !strncmp(str, "[OUT ", strlen("[OUT "))) {
		maxnum = 15;
		start = strlen("[OUT ");
		code = 0x7087;
	} else if (len >= 12 && !strncmp(str, "[ERROR ", strlen("[ERROR ")) && str[11] == ']') {
		const char *hex = str + strlen("[ERROR ");
		bool valid = true;
		for (size_t i = 0; i < 4; ++i) {
			if (hex[i] >= '0' && hex[i] <= '9') {
				num = (num << 4) | (hex[i] - '0');
			} else if (hex[i] >= 'a' && hex[i] <= 'f') {
				num = (num << 4) | (hex[i] - 'a' + 10);
			} else if (hex[i] >= 'A' && hex[i] <= 'F') {
				num = (num << 4) | (hex[i] - 'a' + 10);
			} else {
				valid = false;
				break;
			}
		}

		if (valid) {
			// We have to byteswap, it's in byte order.
			*val = ((num & 0xFF) << 8) | (num >> 8);
			*pos += 11;
			return true;
		}
	}

	if (maxnum != 0) {
		for (size_t i = start; i < len; ++i) {
			if (isdigit((uint8_t)str[i])) {
				num = num * 10 + str[i] - '0';
			} else if (str[i] == ']' && num <= maxnum && i != start) {
				*val = (num << 8) | code;
				*pos += i;
				return true;
			} else {
				break;
			}
		}

		// We never found the valid ] or hit other characters.  Assume just text.
		return false;
	}

	return false;
}

int escaped_utf8_to_game_sjis(const char *utf8, size_t sz, std::vector<uint8_t> &out, bool noPatch) {
	// Skip the quotes on either end.
	utf8++;
	sz -= 2;
	out.reserve(sz);

	uint32_t val;
	int chars = 0;
	for (size_t i = 0; i < sz; ++i) {
		if (utf8[i] == '[' && parse_control_code(utf8 + i, sz - i, &val, &i, noPatch)) {
			out.push_back(val & 0xFF);
			out.push_back(val >> 8);
			continue;
		}
		// Ignore escapes if not before control codes, they were just for parsing.
		if (utf8[i] == '\\') {
			i++;
		}
		char c = utf8[i];
		if ((c & 0x80) == 0 && !noPatch) {
			if (ascii_valid[c] == 0) {
				return -1;
			}
			out.push_back(c);
			chars++;
			continue;
		}

		// Okay, let's first decode to a Unicode code point.
		int next = 1;
		if ((c & 0xE0) == 0xC0) {
			val = c & 0x1F;
		} else if ((c & 0xF0) == 0xE0) {
			val = c & 0x0F;
			next = 2;
		} else if ((c & 0xF0) == 0xF0) {
			val = c & 0x0F;
			next = 3;
		} else {
			return -1;
		}

		for (int n = 0; n < next; ++n) {
			uint8_t nc = (uint8_t)utf8[++i];
			if ((nc & 0xC0) != 0x80) {
				return -1;
			}
			val = (val << 6) | (nc & 0x3F);
		}

		auto it = sjis_table.find(val);
		if (it == sjis_table.end()) {
			return -1;
		}
		out.push_back(it->second & 0xFF);
		out.push_back(it->second >> 8);
		chars++;
	}

	return chars;
}
