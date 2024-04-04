# designed by Cristian Sandu <cristian.sandu@tum.de>

GCC=gcc
CFLAGS=-fPIC -shared -g -O3

# all binaries
ALL = 	clht_lb_res clht_lf_res cuckoo
all: $(ALL)


# CLHT section
CLHT_INCLUDE := -ICLHT/include -ICLHT/external/include
CLHT_PATH = /scratch/christian/cheridb/structures/CLHT

clht_lb_res:
	$(GCC) $(CFLAGS) $(CLHT_INCLUDE) $(CLHT_PATH)/clht_lb_res clht.c -o clht_lb_res.so 

clht_lf_res:
	$(GCC) $(CFLAGS) $(CLHT_INCLUDE) $(CLHT_PATH)/clht_lf_res clht.c -o clht_lf_res.so 

# libcuckoo section
LIBCUCKOO_INCLUDE := -Ilibcuckoo
LIBCUCKOO_PATH = /scratch/christian/cheridb/structures/libcuckoo

cuckoo:
	$(GCC) $(CFLAGS) $(LIBCUCKOO_INCLUDE) cuckoo.cpp -o cuckoo.so 
