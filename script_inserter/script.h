#pragma once

#include <memory>
#include <unordered_map>
#include <vector>
#include "tokenizer.h"

enum class ArgumentType {
	HALFWORD,
	EXPRESSION,
	LABEL,
	STRING,
};

struct Argument {
	ArgumentType type;
	std::vector<uint16_t> value;

	static Argument Label(uint16_t id);
	static Argument Halfword(uint16_t value);
};

class Script;
struct Opcode;

class Statement {
public:
	virtual ~Statement() {
	}

	virtual void update(Script &script, uint16_t pos) {
	}

	virtual bool validate(Script &script, std::vector<std::string> &errors) = 0;
	virtual void encode(Script &script, std::vector<uint8_t> &out) = 0;
	virtual uint16_t size() = 0;
};

class InvalidStatement : public Statement {
public:
	InvalidStatement(const std::string &e, const TokenPos &p) : message(e), pos(p) {
	}

	bool validate(Script &script, std::vector<std::string> &errors) override;
	void encode(Script &script, std::vector<uint8_t> &out) override;
	uint16_t size() override;

protected:
	std::string message;
	TokenPos pos;
};

class LabelDefinition : public Statement {
public:
	LabelDefinition(uint16_t i) : id(i) {
	}

	void update(Script &script, uint16_t pos) override;
	bool validate(Script &script, std::vector<std::string> &errors) override;
	void encode(Script &script, std::vector<uint8_t> &out) override;
	uint16_t size() override;

protected:
	uint16_t id;
};

class DataStatement : public Statement {
public:
	DataStatement(const TokenPos &p) : pos(p) {
	}

	void addHalfword(uint16_t v);
	void addLabel(uint16_t id);

	bool validate(Script &script, std::vector<std::string> &errors) override;
	void encode(Script &script, std::vector<uint8_t> &out) override;
	uint16_t size() override;

protected:
	std::vector<Argument> args;
	TokenPos pos;
};

class CommandStatement : public Statement {
public:
	CommandStatement(const Opcode &i, uint16_t c, std::vector<Argument> &&a, const TokenPos &p) : info(i), code(c), args(a), pos(p) {
	}

	bool validate(Script &script, std::vector<std::string> &errors) override;
	void encode(Script &script, std::vector<uint8_t> &out) override;
	uint16_t size() override;

protected:
	const Opcode &info;
	const uint16_t code;
	std::vector<Argument> args;
	TokenPos pos;
};

class Script {
public:
	bool validate(std::vector<std::string> &errors);
	std::vector<uint8_t> encode();

	void append(std::unique_ptr<Statement> &&statement) {
		statements.push_back(std::move(statement));
	}

	uint16_t findLabelID(const std::string &name) {
		auto it = labelIDs.find(name);
		if (it != labelIDs.end()) {
			return it->second;
		}

		uint16_t id = (uint16_t)labelAddresses.size();
		labelAddresses.push_back(0xFFFF);
		labelIDs[name] = id;
		return id;
	}

	uint16_t getLabel(uint16_t id) {
		return labelAddresses[id];
	}
	void setLabel(uint16_t id, uint16_t address) {
		labelAddresses[id] = address;
	}

protected:
	std::vector<std::unique_ptr<Statement>> statements;
	std::unordered_map<std::string, uint16_t> labelIDs;
	std::vector<uint16_t> labelAddresses;
};
