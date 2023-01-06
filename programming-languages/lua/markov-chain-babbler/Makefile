all: build

build: babbler.c
	gcc -Wall -Werror -std=c99 -pthread  babbler.c -o babbler -llua5.3

clean:
	rm -f babbler babbler.o