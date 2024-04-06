/*
*   @author: Cristian Sandu <cristian.sandu@tum.de>
*/

#include "structure_interface.h"

/* select which version to use */
#ifdef CLHT_LB
    #include <clht_lb.h>
#elif CLHT_LF
    #include <clht_lF.h>
#endif

#include <stdio.h>

void*   ds_init(uint64_t size) {
    uint64_t buckets = size / ENTRIES_PER_BUCKET;
    void* hashtable = clht_create(buckets);
    assert(hashtable != NULL);

    return hashtable;
}

void ds_thread_init(void *ds) {
    /* some ds require thread initialization */
    clht_gc_thread_init(ds, pthread_self());    
}

int ds_insert(void* ds, uint64_t key, uint64_t value) {
    if (clht_put(ds, key, value)) {
        return SUCCESS;
    }
    return FAIL;
}

int ds_read(void* ds, uint64_t key) {
    clht_t* dsh = (clht_t *)(ds);
    if (clht_get(dsh->ht, key) == 0) {
        return FAIL;
    }
    return SUCCESS;
}

int ds_read_range(void* ds, uint64_t key, uint64_t len) {
    int status = 0;
    for(int i=key; i<key+len; i++) {
        status |= clht_get(ds, i);
    }
    return status;
}

int ds_remove(void* ds, uint64_t key) {
    return clht_remove(ds, key);
}
