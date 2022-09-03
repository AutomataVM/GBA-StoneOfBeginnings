#include <cstdio>
#include <cstring>
#include <vector>
#include "inserter.h"
#include "lz77.h"

InsertInfo detect_insert_info(const std::string &filename, uint32_t pos) {
	InsertInfo info;
	info.pos = pos;

	FILE *fp = fopen(filename.c_str(), "rb");
	if (!fp) {
		info.error = "Could not open file";
		return info;
	}
	if (fseek(fp, pos, SEEK_SET) != 0) {
		fclose(fp);
		info.error = "Invalid position, outside file?";
		return info;
	}

	uint8_t header[16]{};
	if (fread(header, sizeof(header), 1, fp) != 1) {
		fclose(fp);
		info.error = "Could not read from file";
		return info;
	}

	if (header[0] == 0x10 && header[3] == 0x00) {
		// Compressed.
		info.compressed = true;
		info.prev_size = header[1] | (header[2] << 8) | (header[3] << 16);

		// Decompress to calculate space.
		std::vector<uint8_t> prev;
		prev.resize(worst_gba_lz77(header));
		if (prev.size() < 16) {
			prev.resize(16);
		}
		memcpy(&prev[0], header, 16);

		if (fread(&prev[16], 1, prev.size() - 16, fp) != prev.size() - 16) {
			fclose(fp);
			info.error = "Could not read previous data";
			return info;
		}

		size_t totalSpace = 0;
		decompress_gba_lz77(prev, &totalSpace);

		info.space_avail = (uint32_t)totalSpace;
		if ((totalSpace & 15) != 0 && fseek(fp, pos + (uint32_t)totalSpace, SEEK_SET) == 0) {
			// Might be padded.  Originally to a multiple of 16, but if we already inserted, maybe more.
			bool okay = true;
			uint32_t pad = 0;
			for (; okay && pad < 0xFFFF; ++pad) {
				int c = fgetc(fp);
				if (c == 0) {
					continue;
				}
				// Another compression header?
				if (c == 0x10 && ((totalSpace + pad) & 15) == 0) {
					okay = fgetc(fp) != EOF && fgetc(fp) != EOF;
					if (fgetc(fp) == 0) {
						// Looks valid if still okay.
						break;
					}
				}
				// Okay, can't be valid then.
				okay = false;
			}
			if (okay) {
				info.space_avail += pad;
			}
		}

		info.valid = true;
	} else if (header[0] == 'P' && header[1] == 'S' && header[2] == 'I' && header[3] == '3' && header[6] == 0 && header[7] == 0) {
		// Uncompressed.
		info.prev_size = header[4] | (header[5] << 8) | (header[6] << 16) | (header[7] << 24);
		info.space_avail = info.prev_size;

		if ((info.prev_size & 15) != 0 && fseek(fp, pos + info.prev_size, SEEK_SET) == 0) {
			// Might be padded.  Originally to a multiple of 16, but if we already inserted, maybe more.
			bool okay = true;
			uint32_t pad = 0;
			for (; okay && pad < 0xFFFF; ++pad) {
				int c = fgetc(fp);
				if (c == 0) {
					continue;
				}
				// Another compression header?
				if (c == 'P' && ((info.prev_size + pad) & 15) == 0) {
					okay = fgetc(fp) == 'S' && fgetc(fp) == 'I' && fgetc(fp) == '3';
					break;
				}
				// Okay, can't be valid then.
				okay = false;
			}
			if (okay) {
				info.space_avail += pad;
			}
		}

		info.valid = true;
	} else {
		fclose(fp);
		info.error = "Invalid header, position points to the wrong place?";
		return info;
	}

	fclose(fp);
	return info;
}

std::vector<uint8_t> prepare_insert(const std::vector<uint8_t> &input, InsertInfo &info) {
	std::vector<uint8_t> data;
	if (!info.valid) {
		return data;
	}

	if (info.compressed) {
		data = compress_gba_lz77(input, LZ77_NORMAL);
		if (data.empty()) {
			info.valid = false;
			info.error = "Compression failed";
		}
	} else {
		data = input;
	}

	if (data.size() > (size_t)info.space_avail) {
		info.valid = false;
		info.error.resize(1024);
		info.error.resize(snprintf(&info.error[0], info.error.size() - 1, "New script is too large, %u bytes out of %u bytes", (uint32_t)data.size(), info.space_avail));
	}

	return data;
}

bool insert_script_data(const std::string &filename, const std::vector<uint8_t> &data, const InsertInfo &info) {
	if (!info.valid) {
		return false;
	}

	FILE *fp = fopen(filename.c_str(), "rb+");
	if (!fp) {
		return false;
	}

	if (fseek(fp, info.pos, SEEK_SET) != 0) {
		fclose(fp);
		return false;
	}

	bool success = fwrite(&data[0], 1, data.size(), fp) == data.size();
	for (size_t i = data.size(); success && i < info.space_avail; ++i) {
		success = fputc(0, fp) != EOF;
	}
	fclose(fp);
	return success;
}
