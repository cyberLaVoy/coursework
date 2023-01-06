#target: dependencies
#<TAB>command to run

all: build

build: to_compile.cpp to_compile.h ...
	g++ -o file_name to_compile.cpp ...

run: build
	./file_name

test: 
	g++ -o file_name -g to_compile.cpp ...
	valgrind --leak-check=full ./file_name

#to run
make target

#to debug
gdb ./file_name

run
print some_expression
list line_number
break function_name
step
next
continue

