#include <stdio.h>
#include <pthread.h>
#include <assert.h>
#include <stdlib.h>
#include <omp.h>

#define BUCKETS (100001)

// BEGIN linked list
// basic node structure
typedef struct __node_t {
    int key;
    struct __node_t *next;
} node_t;

// basic list structure (one used per list)
typedef struct __list_t {
    node_t *head;
    pthread_mutex_t lock;
} list_t;

void List_Init(list_t *L) {
    L->head = NULL;
    pthread_mutex_init(&L->lock, NULL);
}
// END linked list

// BEGIN linked list ganulated lock
void List_Insert(list_t *L, int key) {
    // synchronization not needed
    node_t *new = malloc(sizeof(node_t));
    if (new == NULL) {
        perror("malloc");
        return;
    }
    new->key = key;
    // just lock critical section
    pthread_mutex_lock(&L->lock);
    new->next = L->head;
    L->head = new;
    pthread_mutex_unlock(&L->lock);
}

int List_Lookup(list_t *L, int key) {
    int rv = -1;
    pthread_mutex_lock(&L->lock);
    node_t *curr = L->head;
    while (curr) {
        if (curr->key == key) {
            rv = 0;
            break;
        }
        curr = curr->next;
    }
    pthread_mutex_unlock(&L->lock);
    return rv; // now both success and failure
}
// END linked list ganulated lock

// BEGIN linked list single lock
int List_Insert_Single_Lock(list_t *L, int key) {
    pthread_mutex_lock(&L->lock);
    node_t *new = malloc(sizeof(node_t));
    if (new == NULL) {
        perror("malloc");
        pthread_mutex_unlock(&L->lock);
        return -1; // fail
    }
    new->key = key;
    new->next = L->head;
    L->head = new;
    pthread_mutex_unlock(&L->lock);
    return 0; // success
}

int List_Lookup_Single_Lock(list_t *L, int key) {
    pthread_mutex_lock(&L->lock);
    node_t *curr = L->head;
    while (curr) {
        if (curr->key == key) {
            pthread_mutex_unlock(&L->lock);
            return 0; // success
        }
        curr = curr->next;
    }
    pthread_mutex_unlock(&L->lock);
    return -1; // failure
}
// END linked list single lock

// BEGIN hash table
typedef struct __hash_t {
    list_t lists[BUCKETS];
} hash_t;
void Hash_Init(hash_t *H) {
    for (int i = 0; i < BUCKETS; i++) {
        List_Init(&H->lists[i]);
    }
}
void Hash_Insert(hash_t *H, int key) {
    int bucket = key % BUCKETS;
    List_Insert(&H->lists[bucket], key);
}
int Hash_Lookup(hash_t *H, int key) {
    int bucket = key % BUCKETS;
    return List_Lookup(&H->lists[bucket], key);
}
// END hash table

typedef struct __hash_arg_t {
    hash_t* hashTable;
    int numInserts;
} hash_arg_t;
void *insertIntoHashTableThread(void *arg) {
    hash_arg_t *args = (hash_arg_t *) arg;
    int numInserts = args->numInserts;
    for (int i = 1; i <= numInserts; i++) {
        Hash_Insert(args->hashTable, i);
    }
}
typedef struct __linked_list_arg_t {
    list_t* linkedList;
    int numInserts;
} linked_list_arg_t;
void *insertIntoLinkedListThreadSingleLock(void *arg) {
    linked_list_arg_t *args = (linked_list_arg_t *) arg;
    int numInserts = args->numInserts;
    for (int i = 0; i < numInserts; i++) {
        List_Insert_Single_Lock(args->linkedList, i%BUCKETS);
    }
}
void testHashTable(int numInserts) {
    hash_t hashTable;
    Hash_Init(&hashTable);
    hash_arg_t args;
    args.hashTable = &hashTable;
    args.numInserts = numInserts;
    int numThreads = 4;
    pthread_t threads[numThreads];
    for (int i = 0; i < numThreads; i++) {
        pthread_create(&threads[i], NULL, insertIntoHashTableThread, &args);
    }
    for (int i = 0; i < numThreads; i++) {
        pthread_join(threads[i], NULL);
    }
}
void testLinkedListSingleLock(int numInserts) {
    list_t linkedList;
    List_Init(&linkedList);
    linked_list_arg_t args;
    args.linkedList = &linkedList;
    args.numInserts = numInserts;
    int numThreads = 4;
    pthread_t threads[numThreads];
    for (int i = 0; i < numThreads; i++) {
        pthread_create(&threads[i], NULL, insertIntoLinkedListThreadSingleLock, &args);
    }
    for (int i = 0; i < numThreads; i++) {
        pthread_join(threads[i], NULL);
    }
}

int main(int argc, char *argv[]) {
    time_t t;
    srand((unsigned) time(&t));
    printf("Inserts (Millions), Time (seconds) Concurent Hash Table, Time (seconds) Simple Concurent List \n");
    int numInserts;
    for (int i = 1; i <= 10; i++) {
        numInserts = i*1000000;
        double startTime = omp_get_wtime();
        testHashTable(numInserts);
        double hashTableTimeTaken = omp_get_wtime() - startTime;
        double startTimeSingleLock = omp_get_wtime();
        testLinkedListSingleLock(numInserts);
        double timeTakenSingleLock = omp_get_wtime() - startTimeSingleLock;
        printf("%d, %f, %f \n", i, hashTableTimeTaken, timeTakenSingleLock);
    }
    return 0;
}