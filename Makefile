.SILENT:

install_dev:
	luarocks install simple_test

test:
	LUA_PATH="./src/?.lua;./src/?/init.lua;./src/parser_html/?.lua;;" lua test.lua
