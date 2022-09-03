#pragma once

#include <cstdint>
#include <string>
#include <vector>

struct InsertInfo {
	std::string error;
	uint32_t pos = 0;
	uint32_t space_avail = 0;
	uint32_t prev_size = 0;
	bool valid = false;
	bool compressed = false;
};

InsertInfo detect_insert_info(const std::string &filename, uint32_t pos);
std::vector<uint8_t> prepare_insert(const std::vector<uint8_t> &data, InsertInfo &info);
bool insert_script_data(const std::string &filename, const std::vector<uint8_t> &data, const InsertInfo &info);
