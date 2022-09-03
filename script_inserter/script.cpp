#include "script.h"

bool Script::validate(std::vector<std::string> &errors) {
	uint16_t pos = 0;
	for (auto &s : statements) {
		s->update(*this, pos);
		pos += s->size();
	}
	// We validate in two passes, to ensure size=0 errors bubble to the top.
	for (auto &s : statements) {
		if (s->size() == 0 && !s->validate(*this, errors)) {
			return false;
		}
	}
	for (auto &s : statements) {
		if (s->size() != 0 && !s->validate(*this, errors)) {
			return false;
		}
	}
	return true;
}

std::vector<uint8_t> Script::encode() {
	std::vector<uint8_t> out;
	out.resize(16, 0);
	out[0] = 'P';
	out[1] = 'S';
	out[2] = 'I';
	out[3] = '3';

	for (auto &s : statements) {
		s->encode(*this, out);
	}

	out[4] = (out.size() >> 0) & 0xFF;
	out[5] = (out.size() >> 8) & 0xFF;
	out[6] = (out.size() >> 16) & 0xFF;
	out[7] = (out.size() >> 24) & 0xFF;

	return out;
}

Argument Argument::Label(uint16_t id) {
	std::vector<uint16_t> values;
	values.push_back(id);
	return { ArgumentType::LABEL, values };
}

Argument Argument::Halfword(uint16_t value) {
	std::vector<uint16_t> values;
	values.push_back(value);
	return { ArgumentType::HALFWORD, values };
}

bool InvalidStatement::validate(Script &script, std::vector<std::string> &errors) {
	std::string buffer;
	buffer.resize(message.size() + 1024);
	buffer.resize(snprintf(&buffer[0], buffer.size(), "%s on line %u, column %u", message.c_str(), pos.line, pos.col));
	errors.push_back(buffer);
	return false;
}

void InvalidStatement::encode(Script &script, std::vector<uint8_t> &out) {
}

uint16_t InvalidStatement::size() {
	return 0;
}

void LabelDefinition::update(Script &script, uint16_t pos) {
	script.setLabel(id, pos);
}

bool LabelDefinition::validate(Script &script, std::vector<std::string> &errors) {
	return true;
}

void LabelDefinition::encode(Script &script, std::vector<uint8_t> &out) {
}

uint16_t LabelDefinition::size() {
	return 0;
}

void DataStatement::addHalfword(uint16_t v) {
	args.push_back(Argument::Halfword(v));
}

void DataStatement::addLabel(uint16_t id) {
	args.push_back(Argument::Label(id));
}

bool DataStatement::validate(Script &script, std::vector<std::string> &errors) {
	for (const auto &arg : args) {
		if (arg.type == ArgumentType::LABEL && script.getLabel(arg.value[0]) == 0xFFFF) {
			std::string buffer;
			buffer.resize(1024);
			buffer.resize(snprintf(&buffer[0], buffer.size(), "Undefined label argument near line %u, column %u", pos.line, pos.col));
			errors.push_back(buffer);
			return false;
		}
	}

	return true;
}

void DataStatement::encode(Script &script, std::vector<uint8_t> &out) {
	for (const auto &arg : args) {
		uint16_t val;
		if (arg.type == ArgumentType::LABEL) {
			val = script.getLabel(arg.value[0]);
		} else {
			val = arg.value[0];
		}

		out.push_back(val & 0xFF);
		out.push_back(val >> 8);
	}
}

uint16_t DataStatement::size() {
	return (uint16_t)args.size() * 2;
}

bool CommandStatement::validate(Script &script, std::vector<std::string> &errors) {
	for (const auto &arg : args) {
		if (arg.type == ArgumentType::LABEL && script.getLabel(arg.value[0]) == 0xFFFF) {
			std::string buffer;
			buffer.resize(1024);
			buffer.resize(snprintf(&buffer[0], buffer.size(), "Undefined label argument near line %u, column %u", pos.line, pos.col));
			errors.push_back(buffer);
			return false;
		}
	}

	return true;
}

void CommandStatement::encode(Script &script, std::vector<uint8_t> &out) {
	out.push_back(code & 0xFF);
	out.push_back(code >> 8);

	for (const auto &arg : args) {
		if (arg.type == ArgumentType::LABEL) {
			uint16_t val = script.getLabel(arg.value[0]);
			out.push_back(val & 0xFF);
			out.push_back(val >> 8);
		} else {
			for (uint16_t val : arg.value) {
				out.push_back(val & 0xFF);
				out.push_back(val >> 8);
			}
		}
	}
}

uint16_t CommandStatement::size() {
	uint16_t total = 2;
	for (const auto &arg : args) {
		total += (uint16_t)arg.value.size() * 2;
	}
	return total;
}
