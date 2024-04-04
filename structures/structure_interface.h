#pragma once

#include <stdlib.h>
#include <stdint.h>
#include <assert.h>
#include <pthread.h>

/* returns success - true (0) and fail - false (1) */

#ifdef __cplusplus
extern "C" {  // only need to export C interface if
              // used by C++ source code
#endif

void*   ds_init();
int     ds_insert    (void* ds, uint64_t key, uint64_t value);
int     ds_read      (void* ds, uint64_t key); 
int     ds_read_range(void *ds, uint64_t key, uint64_t len);
int     ds_remove    (void* ds, uint64_t key);

#ifdef __cplusplus
}
#endif