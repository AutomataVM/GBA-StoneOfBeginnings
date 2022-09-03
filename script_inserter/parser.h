#pragma once
#include "script.h"

struct Tokens;

Script parse_script(Tokens &tokens, bool noPatch);
