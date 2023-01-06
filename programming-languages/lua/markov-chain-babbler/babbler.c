#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "lua5.3/lua.h"
#include "lua5.3/lauxlib.h"
#include "lua5.3/lualib.h"

static int c_parse_file(lua_State *L) {
    const char* fileName = luaL_checkstring(L, 1);

    FILE* fp = fopen(fileName, "r");
    fseek(fp, 0, SEEK_END);
    long lsize = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    char* buffer = calloc(1, lsize);
    fread(buffer, lsize, 1, fp);

    lua_pushstring(L, buffer);

    fclose(fp);
    free(buffer);
    return 1;
}

static int c_collect_tolken(lua_State *L) {
    const char* text = luaL_checkstring(L, 1);
    int offset = luaL_checknumber(L, 2);
    if (offset > strlen(text) || offset < 0) {
        char empty[1] = "\0";
        lua_pushstring(L, empty);
        lua_pushnumber(L, -1);
        return 2;
    }
    char* buffer = calloc(1, 1024);
    int i = 0;
    while ((!isspace(text[offset]) || i == 0) && offset < strlen(text)) {
        if ( isalpha(text[offset]) || isdigit(text[offset])) {
            buffer[i] = tolower(text[offset]);
            i++;
        }
        offset++;
    }
    lua_pushstring(L, buffer);
    lua_pushnumber(L, offset+1);
    free(buffer);
    return 2;
}

int main(int argc, char **argv) {
    char* fileName = argv[1]; 
    int numWords = 100;
    if (argc > 2) {
        numWords = atoi(argv[2]);
    }
    int nGrams = 3;
    if (argc > 3) {
        nGrams = atoi(argv[3]);
    }

    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    //register C functions for Lua
    lua_pushcfunction(L, c_parse_file);
    lua_setglobal(L, "c_parse_file");
    lua_pushcfunction(L, c_collect_tolken);
    lua_setglobal(L, "c_collect_tolken");

    luaL_loadfile(L, "babbler.lua");
    //lua_pcall(L, number_of_args, number_of_returns, errfunc_inx);
    lua_pcall(L,0,0,0);
    lua_getglobal(L, "main");
    lua_pushstring(L, fileName);
    lua_pushnumber(L, numWords);
    lua_pushnumber(L, nGrams);
    lua_pcall(L, 3, 0, 0);

    lua_close(L);
    return 0;
}