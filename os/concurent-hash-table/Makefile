
default: program

thread.o: thread.c 
	gcc -c thread.c -o thread.o

program: thread.o
	gcc thread.o -pthread -lgomp -o program

clean:
	-rm -f thread.o
	-rm -f program

test: 
	valgrind --leak-check=full ./program