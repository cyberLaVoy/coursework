#define _BSD_SOURCE
#include <assert.h>
#include <stdbool.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <semaphore.h>
#include <time.h>
#include <string.h>

// total number of sharks and divers
const int SHARK_COUNT = 6;
const int DIVER_COUNT = 2;

// capacity of the reef (this many sharks OR divers)
const int MAX_IN_REEF = 2;

// max time a shark waits before getting hungry (in microseconds)
const int SHARK_WAITING_TIME = 2000000;

// max time a shark spends feeding in the reef
const int SHARK_FISHING_TIME = 2000000;

// max time a diver waits before wanting to fish
const int DIVER_WAITING_TIME = 2000000;

// max time a diver spends fishing in the reef
const int DIVER_FISHING_TIME = 2000000;

// total time the simulation should run (in seconds)
const int TOTAL_SECONDS = 60;

// whether or not each shark/diver is currently in the reef
bool *divers_fishing;
bool *sharks_feeding;

//
// declare synchronization variables here
//
sem_t smutex; // protects numSharksInReef
sem_t dmutex; // protects numDiversInReef
sem_t rmutex; // protects the reef

sem_t thingsFeeding;
sem_t readyToEnterReaf;

int numDiversInReef;
int numSharksInReef;
//
// end synchronization variables
//

void report(void) {
    // shark report
    int total_sharks = 0;
    char shark_report[100];
    shark_report[0] = 0;

    for (int i = 0; i < SHARK_COUNT; i++) {
        if (sharks_feeding[i]) {
            strcat(shark_report, "+");
            total_sharks++;
        } else {
            strcat(shark_report, " ");
        }
    }

    // diver report
    int total_divers = 0;
    char diver_report[100];
    diver_report[0] = 0;

    for (int i = 0; i < DIVER_COUNT; i++) {
        if (divers_fishing[i]) {
            strcat(diver_report, "*");
            total_divers++;
        } else {
            strcat(diver_report, " ");
        }
    }

    // reef report
    char reef_report[100];
    reef_report[0] = 0;
    for (int i = 0; i < total_sharks; i++)
        strcat(reef_report, "+");
    for (int i = 0; i < total_divers; i++)
        strcat(reef_report, "*");
    for (int i = strlen(reef_report); i < MAX_IN_REEF; i++)
        strcat(reef_report, " ");

    printf("[%s] %s [%s]\n", shark_report, reef_report, diver_report);
    if (total_sharks > 0 && total_divers > 0)
        printf("!!! ERROR: diver getting eaten\n");

    fflush(stdout);
}


// function to simulate a single shark
void *shark(void *arg) {
    int k = *(int *) arg;
    printf("starting shark #%d\n", k);
    fflush(stdout);

    for (;;) {
        // sleep for some time
        usleep(random() % SHARK_WAITING_TIME);

        //
        // write code here to safely start the shark feeding
        // note: call report() after setting sharks_feeding[k] to true
        //
        sem_wait(&readyToEnterReaf);
        sem_wait(&smutex);
        if (numSharksInReef == 0) {
            sem_wait(&rmutex);
        }
        numSharksInReef++;
        sem_post(&smutex);
        sem_post(&readyToEnterReaf);

        sem_wait(&thingsFeeding);

        sharks_feeding[k] = true;
        report();
        //
        // end code to start shark feeding
        //

        // feed for a while
        usleep(random() % SHARK_FISHING_TIME);

        //
        // write code here to stop the shark feeding
        // note: call report() after setting sharks_feeding[k] to false
        //
        sem_post(&thingsFeeding);

        sharks_feeding[k] = false;
        report();

        sem_wait(&smutex);
        numSharksInReef--;
        if (numSharksInReef == 0) {
            sem_post(&rmutex);
        }
        sem_post(&smutex);
        //
        // end code to stop shark feeding
        //
    }

    return NULL;
}

// function to simulate a single diver
void *diver(void *arg) {
    int k = *(int *) arg;
    printf("starting diver #%d\n", k);
    fflush(stdout);

    for (;;) {
        // sleep for some time
        usleep(random() % DIVER_WAITING_TIME);

        //
        // write code here to safely start the diver fishing
        // note: call report() after setting divers_fishing[k] to true
        //
        sem_wait(&readyToEnterReaf);
        sem_wait(&dmutex);
        if (numDiversInReef == 0) {
            sem_wait(&rmutex);
        }
        numDiversInReef++;
        sem_post(&dmutex);
        sem_post(&readyToEnterReaf);

        sem_wait(&thingsFeeding);

        divers_fishing[k] = true;
        report();

        //
        // end code to start diver fishing
        //

        // fish for a while
        usleep(random() % DIVER_FISHING_TIME);

        //
        // write code here to stop the diver feeding
        // note: call report() after setting divers_fishing[k] to false
        //
        sem_post(&thingsFeeding);

        divers_fishing[k] = false;
        report();

        sem_wait(&dmutex);
        numDiversInReef--;
        if (numDiversInReef == 0) {
            sem_post(&rmutex);
        }
        sem_post(&dmutex);
        //
        // end code to stop diver fishing
        //
    }

    return NULL;
}

int main(int argc, char **argv) {
    //
    // initialize synchronization variables here
    //
    sem_init(&smutex,0,1); // protects numSharksInReef
    sem_init(&dmutex,0,1); // protects numDiversInReef
    sem_init(&rmutex,0,1);; // protects the reef

    sem_init(&thingsFeeding,0,MAX_IN_REEF);
    sem_init(&readyToEnterReaf,0,1);

    numDiversInReef = 0;
    numSharksInReef = 0;
    //
    // end of synchronization variable initialization
    //

    // initialize shared state
    sharks_feeding = malloc(sizeof(bool) * SHARK_COUNT);
    assert(sharks_feeding != NULL);
    for (int i = 0; i < SHARK_COUNT; i++)
        sharks_feeding[i] = false;

    divers_fishing = malloc(sizeof(bool) * SHARK_COUNT);
    assert(divers_fishing != NULL);
    for (int i = 0; i < DIVER_COUNT; i++)
        divers_fishing[i] = false;

    pthread_t sharks[SHARK_COUNT];
    pthread_t divers[DIVER_COUNT];

    // spawn the sharks
    int shark_counts[SHARK_COUNT];
    for (int i = 0; i < SHARK_COUNT; i++) {
        // create a new thread for this shark
        shark_counts[i] = i;
        int s = pthread_create(&sharks[i], NULL, shark, &shark_counts[i]);
        assert(s == 0);
        s = pthread_detach(sharks[i]);
        assert(s == 0);
    }

    // spawn the divers
    int diver_counts[DIVER_COUNT];
    for (int i = 0; i < DIVER_COUNT; i++) {
        // create a new thread for this diver
        diver_counts[i] = i;
        int s = pthread_create(&divers[i], NULL, diver, &diver_counts[i]);
        assert(s == 0);
        s = pthread_detach(divers[i]);
        assert(s == 0);
    }

    // let the simulation run for a while
    sleep(TOTAL_SECONDS);
    fflush(stdout);

    return 0;
}