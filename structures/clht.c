#include "structure_interface.h"

struct clht_t;
struct clht_t*  clht_create(uint64_t);
void  (clht_gc_thread_init)(struct clht_t*, int);
int  (clht_put)(struct clht_t*, int, int);  /* returns true (0) and false (1) */
int  (clht_remove)(struct clht_t*, int);
int  (clht_get)(struct clht_t*, int);

void*   ds_init() {
    void* hashtable = clht_create(256);
    assert(hashtable != NULL);

    clht_gc_thread_init(hashtable, pthread_self());    
    return hashtable;
}

int     ds_insert(void* ds, uint64_t key, uint64_t value) {
    return clht_put(ds, key, value);
}

int     ds_read(void* ds, uint64_t key) {
    return clht_get(ds, key);
}

int     ds_read_range(void* ds, uint64_t key, uint64_t len) {
    int status = 0;
    for(int i=key; i<key+len; i++) {
        status |= clht_get(ds, i);
    }
    return status;
}

int     ds_remove(void* ds, uint64_t key) {
    return clht_remove(ds, key);
}