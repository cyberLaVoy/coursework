
#include "malloc.h"
#include <unistd.h>
#include <stdio.h>
#include <assert.h>

#define wordSize 8
#define umagic 0xcafe
#define fmagic 0xbabe

static void* bheap = NULL;
static fheader_t* fhead = NULL;

void* getDivision(fheader_t* worseFit, size_t totalSizeNeeded) {
    if ((worseFit->size+sizeof(uheader_t))-totalSizeNeeded < sizeof(uheader_t)+wordSize) {
        return NULL;
    }
    void* division = (void*)worseFit;
    division += sizeof(uheader_t);
    division += worseFit->size;
    division -= totalSizeNeeded;
    worseFit->size = worseFit->size - totalSizeNeeded;
    return division;
}
void* findWorseFit(size_t totalSizeNeeded) {
    if (fhead == NULL) {
        return NULL;
    }
    int maxSize = fhead->size;
    fheader_t* worseFit = fhead;
    fheader_t* previousNeeded = NULL;
    fheader_t* previous = NULL;
    fheader_t* next = fhead;
    fheader_t* current;
    while(next != NULL) {
        current = next;
        if (current->size > maxSize) {
            maxSize = current->size;
            worseFit = current;
            previousNeeded = previous;
        }
        previous = current;
        next = current->next;
    }
    assert(worseFit->magic == fmagic);
    size_t potentialSize = maxSize+sizeof(uheader_t);
    if (potentialSize < totalSizeNeeded) {
        return NULL;
    }
    else if (potentialSize == totalSizeNeeded) {
        if (worseFit == fhead) {
            fhead = fhead->next;
        }
        else {
            previousNeeded->next = worseFit->next;
        }
        return (void*)worseFit;
    }
    else {
        return getDivision(worseFit, totalSizeNeeded);
    }
}

void* mymalloc(size_t size) {
    if (bheap == NULL) {
        bheap = sbrk(0); // set heap beginning
    }
    size_t actualSize = (size + sizeof(uheader_t) + (wordSize-1)) & ~(wordSize-1);
    uheader_t* blockptr = findWorseFit(actualSize);
    if (blockptr == NULL) {
        blockptr = sbrk(actualSize); 
    }
    blockptr->magic = umagic;
    blockptr->size = actualSize - sizeof(uheader_t);
    assert(blockptr->magic == umagic);
    blockptr++;

    return (void*)blockptr;
}

void coalesce(fheader_t* fptr) {
    if (fptr < fhead) {
        if ((void*)fptr+sizeof(uheader_t)+fptr->size == fhead) {
            fptr->size += (fhead->size+wordSize);
            fptr->next = fhead->next;
            fhead = fptr;
        }
        else {
            fptr->next = fhead;
            fhead = fptr;
        }
    }
    else if (fptr > fhead) {
        fheader_t* next = fhead;
        fheader_t* current;
        while(fptr > next && next != NULL) {
            current = next;
            next = current->next;
        }
        void* fptrEnd = (void*)fptr+sizeof(uheader_t)+fptr->size;
        void* currentEnd = (void*)current+sizeof(uheader_t)+current->size;
        if (fptrEnd == next && currentEnd == fptr) {
            current->size += ((fptr->size+sizeof(uheader_t)) + (next->size+sizeof(uheader_t)));
            current->next = next->next;
        }
        else if (fptrEnd == next) {
            fptr->size += (next->size+sizeof(uheader_t));
            current->next = fptr;
            fptr->next = next->next;
        }
        else if (currentEnd == fptr) {
            current->size += (fptr->size+sizeof(uheader_t));
            current->next = next;
        }
        else {
            fptr->next = next;
            current->next = fptr;
        }
    }
}

void myfree(void* ptr) {
    uheader_t* uptr = (uheader_t*) ptr;
    uptr--;
    assert(uptr->magic == umagic);
    uptr->magic = fmagic;
    fheader_t* fptr = (fheader_t*) uptr;
    if (fhead == NULL) {
        fhead = fptr;
        fhead->next = NULL;
    }
    else {
        coalesce(fptr);
    }
}

void displayHeap() {
    printf("**Heap**\n");
    void* next = bheap; 
    void* eheap = sbrk(0);
    while (next < eheap) {
        int* temp = (int*)next;
        int magicNumber = *temp;
        if (magicNumber == umagic) {
            uheader_t* usedBlock = (uheader_t*) next;
            int blockSize = usedBlock->size;
            printf("Address: %p\n", usedBlock);
            printf("Block type: Used\n");
            printf("Magic number: %d\n", magicNumber);
            printf("Block size: %d\n", blockSize);
            next += sizeof(uheader_t);
            next += blockSize; 
        }
        else if (magicNumber == fmagic) {
            fheader_t* freeBlock = (fheader_t*) next;
            int blockSize = freeBlock->size;
            printf("Address: %p\n", freeBlock);
            printf("Block type: Free\n");
            printf("Magic number: %d\n", magicNumber);
            printf("Block size: %d\n", blockSize);
            next += sizeof(uheader_t);
            next += blockSize; 
        }
        else {
            fheader_t* unknownBlock = (fheader_t*) next;
            int blockSize = unknownBlock->size;
            printf("Address: %p\n", unknownBlock);
            printf("Block type: UNKNOWN\n");
            printf("Magic number: %d\n", magicNumber);
            printf("Block size: %d\n", blockSize);
            next += sizeof(uheader_t);
            next += blockSize; 
        }
        printf("\n");
    }
}
void displayFreeList() {
    printf("**Free List**\n");
    fheader_t* next = fhead;
    while(next != NULL) {
        fheader_t* current = next;
        printf("Address: %p\n", current);
        printf("Magic: %d\n", current->magic);
        printf("Size: %d\n", current->size);
        printf("Next: %p\n", current->next);
        next = current->next;
        printf("\n");
    }
}
void report() {
    printf("**************Report**************\n");
    printf("Begining of heap: %p\n", bheap);
    void* eheap = sbrk(0);
    printf("End of heap: %p\n", eheap);
    printf("Size of heap: %ld\n", ((long)eheap) - ((long)bheap));
    printf("\n");
    displayFreeList();
    displayHeap();
}