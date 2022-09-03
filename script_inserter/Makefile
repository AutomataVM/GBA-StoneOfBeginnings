CXX ?= g++

CFLAGS ?= -O2
CXXFLAGS ?= $(CFLAGS)

SRC_CXXFLAGS += -std=c++14

swordcraft3c: main.cpp expr.cpp inserter.cpp lz77.cpp opcodes.cpp parser.cpp script.cpp sjis.cpp tokenizer.cpp
	$(CXX) -o $@ $(CXXFLAGS) $(SRC_CXXFLAGS) $^

swordcraft3-menu: menu.cpp expr.cpp lz77.cpp sjis.cpp tokenizer.cpp
	$(CXX) -o $@ $(CXXFLAGS) $(SRC_CXXFLAGS) $^

all: swordcraft3c swordcraft3-menu

.PHONY: all
