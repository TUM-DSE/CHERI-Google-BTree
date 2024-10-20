/*
*   @details:
*       1. Generate 64bit keys and 64bit values from an uniform random distribution to be inserted, removed or queried.
*       2. Evaluation of Insertion: from 0% -> filling_factor of the total capacity.
*       3. Evaluation of Queries: Positive and Negative queries (queries_factor) (success_factor).
*       4. Evaluation of Deletion: Remove a selections of keys until the usage reaches ~50%.
*
*   @author: Cristian Sandu <cristian.sandu@tum.de>
*/

#include "utils.hpp"
#include "hash.hpp"
#include <nlohmann/json.hpp>
#include <iostream>
#include <functional>
#include <vector>
#include <time.h>
#include <fstream>
#include <thread>
#include <atomic>
#include <random>
#include <unistd.h>

#include <sys/sysctl.h>
#include <sys/types.h>
#include <sys/user.h>

void*       libhandle = nullptr;
void*       generic_structure = nullptr;

void*       (*ds_init)(uint64_t);
void        (*ds_thread_init)(void*);
int         (*ds_insert)(void*, uint64_t, uint64_t);
int         (*ds_remove)(void*, uint64_t);
int         (*ds_read)(void*, uint64_t);
int         (*ds_read_range)(void*, uint64_t, uint64_t);
uint64_t    (*ds_get_size)(void*);

/* hashing function */
uint64_t            (*hash_fn)(uint64_t);

/* parameters */
std::vector<uint64_t> usedkeys;
std::mutex            g_mutex;
Barrier               tbarrier;

/* data extracted from the program */
LogFile logfileMemory("");

std::atomic<uint64_t> counter(0);
uint64_t next_value() {
    return std::atomic_fetch_add(&counter, 1ULL);
}

void getCurrentProcessInfo(char *filename) {
    int mib[4];
    struct kinfo_proc proc;
    size_t len = sizeof(proc);

    // Get the current process ID
    pid_t pid = getpid();

    // Set up the mib array to get the process information
    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = pid;

    // Get the process information
    if (sysctl(mib, 4, &proc, &len, NULL, 0) == -1) {
        perror("sysctl");
        return;
    }

    FILE* fout = fopen(filename, "w");
    if (fout == NULL) {
        perror("fopen");
        exit(1);
    }

    // Write process information to the file
    fprintf(fout, "Process ID: %d\n", proc.ki_pid);
    fprintf(fout, "Process Name: %s\n", proc.ki_comm);
    fprintf(fout, "Virtual Memory Size: %lu KB\n", proc.ki_size / 1024);
    fprintf(fout, "Resident Set Size: %lu KB\n", proc.ki_rssize * getpagesize() / 1024);

    // Close the file
    fclose(fout);
}


void dataset_performfill(void* ds, const double filling_factor, const uint64_t maximum_capacity) {
    const uint64_t capacity = filling_factor * maximum_capacity;
    std::vector<std::pair<uint64_t, uint64_t>> memdata;

    for (uint64_t i=0; i<capacity; i++) {
        const uint64_t key_num  = next_value();
        const uint64_t key      = hash_fn(key_num);
        const uint64_t value    = hash_fn(next_value());

        ds_insert(ds, key, value);
    }
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        std::cerr << "[error] format: <path to so> <path to config file> <log file name>" << std::endl;
        exit(1);
    }
    srand(time(NULL));      /* prepare the randomness */

    std::string libpath   = argv[1];

    std::ifstream f(argv[2]);
    nlohmann::json config_data = nlohmann::json::parse(f);
    logfileMemory.set_name(std::string(argv[3]) + "_memory.out");

    if (initialize(libpath) != 0) {
        std::cerr << "[error] failed: " << std::endl;
        exit(1);
    }

    if (config_data["distribution"] == "zipfian") {
        hash_fn = hash_zipfian;
    } else if (config_data["distribution"] == "uniform") {
        hash_fn = hash_uniform;
    } else {
        throw std::runtime_error("unknown distribution type");
    }

    /* all functions have been loaded at this point */
    const uint64_t capacity     = config_data["capacity"];
    const double filling_factor = config_data["performfill"]["filling_factor"];

    void* ds = ds_init(capacity);
    getCurrentProcessInfo("initial_memory.txt");
    dataset_performfill(ds, filling_factor, capacity);
    getCurrentProcessInfo("final_memory.txt");
    return 0;
}