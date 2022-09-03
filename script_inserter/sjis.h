#pragma once

#include <cstdint>
#include <vector>

int escaped_utf8_to_game_sjis(const char *utf8, size_t sz, std::vector<uint8_t> &out, bool noPatch);
