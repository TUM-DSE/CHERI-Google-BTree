CXX= g++
CXXFLAGS=-O3

load_injector: load_injector.cc tpcc/*pp
	$(CXX) $(CXXFLAGS) load_injector.cc -o load_injector

all: load_injector

clean:
	        rm load_injector
