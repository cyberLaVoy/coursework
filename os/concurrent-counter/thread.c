#include <stdio.h>
#include <pthread.h>
#include <assert.h>
#include <stdlib.h>
#include <omp.h>

#define NUMCPUS 4

// BEGIN precise counter
typedef struct __precise_counter_t {
    int value;
    pthread_mutex_t lock;
} precise_counter_t;

void precise_counter_init(precise_counter_t *c) {
    c->value = 0;
    pthread_mutex_init(&c->lock, NULL);
}

void increment(precise_counter_t *c) {
    pthread_mutex_lock(&c->lock);
    c->value++;
    pthread_mutex_unlock(&c->lock);
}

void decrement(precise_counter_t *c) {
    pthread_mutex_lock(&c->lock);
    c->value--;
    pthread_mutex_unlock(&c->lock);
}

int getPreciseCount(precise_counter_t *c) {
    pthread_mutex_lock(&c->lock);
    int rc = c->value;
    pthread_mutex_unlock(&c->lock);
return rc;
}
// END precise counter

// BEGIN sloppy counter 
typedef struct __sloppy_counter_t {
    int global; // global count
    pthread_mutex_t glock; // global lock
    int local[NUMCPUS]; // local count (per cpu)
    pthread_mutex_t llock[NUMCPUS]; // ... and locks
    int threshold; // update frequency
} sloppy_counter_t;

// init: record threshold, init locks, init values
// of all local counts and global count
void sloppy_counter_init(sloppy_counter_t *c, int threshold) {
    c->threshold = threshold;
    c->global = 0;
    pthread_mutex_init(&c->glock, NULL);
    for (int i = 0; i < NUMCPUS; i++) {
        c->local[i] = 0;
        pthread_mutex_init(&c->llock[i], NULL);
    }
}
// update: usually, just grab local lock and update local amount
// once local count has risen by ’threshold’, grab global
// lock and transfer local values to it
void updateSloppyCounter(sloppy_counter_t *c, int threadID, int amt) {
    int cpu = threadID % NUMCPUS;
    pthread_mutex_lock(&c->llock[cpu]);
    c->local[cpu] += amt; // assumes amt > 0
    if (c->local[cpu] >= c->threshold) { // transfer to global
        //printf("%d threshold reached \n", cpu);
        pthread_mutex_lock(&c->glock);
        c->global += c->local[cpu];
        pthread_mutex_unlock(&c->glock);
        c->local[cpu] = 0;
    }
    else {
        //printf("%d %d/%d \n", cpu, c->local[cpu], c->threshold);
    }
    pthread_mutex_unlock(&c->llock[cpu]);
}
// get: just return global amount (which may not be perfect)
int getSloppyGlobalCount(sloppy_counter_t *c) {
    pthread_mutex_lock(&c->glock);
    int val = c->global;
    pthread_mutex_unlock(&c->glock);
    return val; // only approximate!
}
// END sloppy counter

void *incrementPreciseCounterThread(void *arg) {
    precise_counter_t *preciseCounter = (precise_counter_t *) arg;
    int numUpdates = 1000000;
    for (int i = 0; i < numUpdates; i++) {
        increment(preciseCounter);
    }
}

typedef struct __sloppy_arg_t {
    sloppy_counter_t* counter;
    int threadID;
    int amount;
} sloppy_arg_t;
void *updateSloppyCounterThread(void *arg) {
    sloppy_arg_t *sloppyArgs = (sloppy_arg_t *) arg;
    int numUpdates = 1000000;
    for (int i = 0; i < numUpdates; i++) {
        updateSloppyCounter(sloppyArgs->counter, sloppyArgs->threadID, sloppyArgs->amount);
    }
}

void testPreciseCounter(int numThreads) {
    precise_counter_t counter;
    precise_counter_init(&counter);
    pthread_t threads[numThreads];
    for (int i = 0; i < numThreads; i++) {
        pthread_create(&threads[i], NULL, incrementPreciseCounterThread, &counter);
    }
    for (int i = 0; i < numThreads; i++) {
        pthread_join(threads[i], NULL);
    }
    //printf("total count %d\n", getPreciseCount(&counter));
}
void testSloppyCounter(int numThreads, int threshold) {
    sloppy_counter_t sloppyCounter;
    sloppy_counter_init(&sloppyCounter, threshold);
    pthread_t threads[numThreads];
    sloppy_arg_t args[numThreads];
    for (int i = 0; i < numThreads; i++) {
        args[i].counter = &sloppyCounter;
        args[i].threadID = i;
        args[i].amount = 1;
        pthread_create(&threads[i], NULL, updateSloppyCounterThread, &args[i]);
    }
    for (int i = 0; i < numThreads; i++) {
       pthread_join(threads[i], NULL);
    }
    //printf("total count %d\n", getSloppyGlobalCount(&sloppyCounter));
}
int main(int argc, char *argv[]) {
    printf("%s, %s\n", "Approximation Factor (S)", "Time (seconds)");
    int threshold = 1;
    for (int i = 0; i <= 10; i++) {
        double startTime = omp_get_wtime();
        testSloppyCounter(4, threshold);
        double timeTaken = omp_get_wtime() - startTime;
        printf("%d, %f\n", threshold, timeTaken);
        threshold *= 2;
    }
    printf("%s, %s, %s\n", "Threads", "Time (seconds) Sloppy", "Time (seconds) Precise");
    int maxNumThreads = 4;
    for (int i = 1; i <= maxNumThreads; i++) {
        int numThreads = i;
        double sloppyStartTime = omp_get_wtime();
        testSloppyCounter(i, 1024);
        double sloppyTimeTaken = omp_get_wtime() - sloppyStartTime;
        double preciseStartTime = omp_get_wtime();
        testPreciseCounter(i);
        double preciseTimeTaken = omp_get_wtime() - preciseStartTime;
        printf("%d, %f, %f\n", numThreads, sloppyTimeTaken, preciseTimeTaken);
    }
    return 0;
}