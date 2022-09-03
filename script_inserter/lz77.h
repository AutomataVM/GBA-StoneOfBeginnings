#pragma once

#include <cstdint>
#include <vector>

enum LZ77Flags {
	LZ77_NORMAL = 0x0000,
	LZ77_FAST = 0x0001,
	LZ77_VRAM_SAFE = 0x0002,
	LZ77_REVERSE = 0x0004,
};

inline size_t worst_gba_lz77(size_t orig) {
	return 4 + orig + (orig / 8);
}

inline size_t worst_gba_lz77(uint8_t *header) {
	return worst_gba_lz77(header[1] | (header[2] << 8) | (header[3] << 16));
}

std::vector<uint8_t> compress_gba_lz77(const std::vector<uint8_t> &input, int flags);
std::vector<uint8_t> decompress_gba_lz77(const std::vector<uint8_t> &input, size_t *compressed_size = nullptr);
