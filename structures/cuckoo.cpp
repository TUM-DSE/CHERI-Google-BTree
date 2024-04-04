#include "structure_interface.h"
#include <libcuckoo/cuckoohash_map.hh>

struct int_str_table;
struct int_str_table*  int_str_table_init(uint64_t);
int  (int_str_table_insert)(struct clht_t*, int, int);  /* returns true (0) and false (1) */
int  (int_str_table_find)(struct clht_t*, int);
int  (clht_remove)(struct clht_t*, int);

extern "C" {

void*   ds_init() {
    return static_cast<void*>(new libcuckoo::cuckoohash_map<uint64_t, uint64_t>());
}

int     ds_insert(void* ds, uint64_t key, uint64_t value) {
    libcuckoo::cuckoohash_map<uint64_t, uint64_t>* dc =
        static_cast<libcuckoo::cuckoohash_map<uint64_t, uint64_t> *>(ds);
    return dc->insert(key, value);
}

int     ds_read(void* ds, uint64_t key) {
    libcuckoo::cuckoohash_map<uint64_t, uint64_t>* dc =
        static_cast<libcuckoo::cuckoohash_map<uint64_t, uint64_t> *>(ds);
    return dc->find(key);
}

int     ds_read_range(void* ds, uint64_t key, uint64_t len) {
    // Not yet implemented
    return 0;
}

int     ds_remove(void* ds, uint64_t key) {
    libcuckoo::cuckoohash_map<uint64_t, uint64_t>* dc =
        static_cast<libcuckoo::cuckoohash_map<uint64_t, uint64_t> *>(ds);
    return dc->erase(key);
}

}