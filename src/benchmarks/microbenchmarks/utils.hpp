/*
*   @author: Cristian Sandu <cristian.sandu@tum.de>
*/

#pragma once

#include <string>
#include <iostream>
#include <mutex>
#include <vector>
#include <dlfcn.h>
#include <stdlib.h>
#include <chrono>
#include <condition_variable>

#define MEASURE_TIME(func, start_time, end_time, retval) {      \
    try {                                                       \
        start_time = std::chrono::system_clock::now();          \
        retval = func;                                          \
        end_time   = std::chrono::system_clock::now();          \
    } catch (...) {                                             \
        end_time   = std::chrono::system_clock::now();          \
        retval     = -1;                                        \
    }                                                           \
}

#define EXECUTE_PARALLEL(threadnum, func, ...) {            \
    std::vector<std::thread> threads;                       \
    for (size_t i = 0; i < threadnum; i++) {                \
        threads.emplace_back(func, i, ##__VA_ARGS__);       \
    }                                                       \
                                                            \
    for (auto& thread : threads) {                          \
        thread.join();                                      \
    }                                                       \
}

/* the datastructure pointer */
extern void*       libhandle;
extern void*       generic_structure;

extern void*       (*ds_init)(uint64_t);
extern void        (*ds_thread_init)(void*);
extern int         (*ds_insert)(void*, uint64_t, uint64_t);
extern int         (*ds_remove)(void*, uint64_t);
extern int         (*ds_read)(void*, uint64_t);
extern int         (*ds_read_range)(void*, uint64_t, uint64_t);

uint64_t initialize(std::string libpath);

class LogFile {
public:
    LogFile(std::string log_name);
    void add_log(std::string function_name, uint64_t thread_id, uint64_t key_num,
        uint64_t key, uint64_t value, uint64_t status,
        std::chrono::time_point<std::chrono::system_clock> start_time, 
        std::chrono::time_point<std::chrono::system_clock> end_time);
    void save_logfile();
    void set_name(std::string log_name) { this->log_name = log_name; }
private:
    std::string   log_name;
    std::mutex    g_mutex;
    std::vector<std::string> latency_logs;
};

class Barrier {
public:
    Barrier() : num_threads(0), count(0) {}

    void set_numthreads(const uint64_t num_threads) {
        this->num_threads = num_threads;
    }
    
    void wait() {
        std::unique_lock<std::mutex> lock(mtx);
        count += 1;
        if (count == num_threads) {
            cv.notify_all();
            count = 0;
        } else {
            cv.wait(lock, [this] { return count == num_threads; });
        }
    }

private:
    std::mutex mtx;
    std::condition_variable cv;
    std::uint64_t num_threads;
    std::uint64_t count;
};
