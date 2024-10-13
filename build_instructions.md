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


