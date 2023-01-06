#include "malloc.h"
#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {
    printf(" "); //printf allocates memory for its self
    void* ptr3 = mymalloc(8);
    void* ptr4 = mymalloc(8);
    myfree(ptr4);
    myfree(ptr3);
    void* ptr; 
    ptr = mymalloc(100);
    myfree(ptr);
    ptr = mymalloc(8);
    //mymalloc(24);
    myfree(ptr);
    //mymalloc(200);
    void* ptr1 = mymalloc(4);
    //mymalloc(4);
    //mymalloc(16);
    myfree(ptr1);
    void* ptr2 = mymalloc(16);
    myfree(ptr2);
    mymalloc(80);

    report();
    return 0;
}