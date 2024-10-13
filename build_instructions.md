# How to build?

## Structures

### CLHT (LF, LB)

Inside the `CLHT\externa` are two submodules: `ssmem` and `sspfd`.

#### SSMEM
```
  cd CLHT/external/ssmem
  gmake -f Makefile_ace
  cp libssmem.a ../lib
  cp include/ssmem.h ../include
  cd ../../..
```
You can run the tests `ssmem_test` to check if the lib works (it must work).

#### SSPDF
```
  cd CLHT/external/sspfd
  gmake -f Makefile libsspfd.a
  cp libsspfd.a ../lib
  cp sspfd.h ../include
  cd ../../..
```

Build CLHT directory
```
  cd CLHT && gmake -f Makefile_ace
```

Test CLHT:
```
  # lock base approach
  ./clht_lb

  # lock free approach !!! the -b (buckets) must be a power of 2!!!!
  ./clht_lf -b 1024
```

### oneTBB 

Choosing the build type - release/debug. For the hashtable, only `tbb` must be built from the entire project.
```
  cmake -DCMAKE_BUILD_TYPE=Release .
  or
  cmake -DCMAKE_BUILD_TYPE=Debug .
  make tbb
```

Source the path to be used during evaluation.
```
 # for release
 export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/home/cristian/cheridb/structures/oneTBB/clang_14.0_cxx11_64_release
 # for debug
 export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/home/cristian/cheridb/structures/oneTBB/clang_14.0_cxx11_64_relwithdebinfo
```

Copy the resulted `.so` to `./lib`.


