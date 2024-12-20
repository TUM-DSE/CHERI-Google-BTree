# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Default target executed when no arguments are given to make.
default_target: all
.PHONY : default_target

# Allow only one "make -f Makefile2" at a time, but pass parallelism.
.NOTPARALLEL:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local64/bin/cmake

# The command to remove a file.
RM = /usr/local64/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/cristian/cheridb_nocap/structures/google-btree

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/cristian/cheridb_nocap/structures/google-btree

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target test
test:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running tests..."
	/usr/local64/bin/ctest --force-new-ctest-process $(ARGS)
.PHONY : test

# Special rule for the target test
test/fast: test
.PHONY : test/fast

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake cache editor..."
	/usr/local64/bin/ccmake -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache
.PHONY : edit_cache/fast

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/local64/bin/cmake --regenerate-during-build -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache
.PHONY : rebuild_cache/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /home/cristian/cheridb_nocap/structures/google-btree/CMakeFiles /home/cristian/cheridb_nocap/structures/google-btree//CMakeFiles/progress.marks
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /home/cristian/cheridb_nocap/structures/google-btree/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean
.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named btree_test

# Build rule for target.
btree_test: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 btree_test
.PHONY : btree_test

# fast build rule for target.
btree_test/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_test.dir/build.make CMakeFiles/btree_test.dir/build
.PHONY : btree_test/fast

#=============================================================================
# Target rules for targets named safe_btree_test

# Build rule for target.
safe_btree_test: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 safe_btree_test
.PHONY : safe_btree_test

# fast build rule for target.
safe_btree_test/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/safe_btree_test.dir/build.make CMakeFiles/safe_btree_test.dir/build
.PHONY : safe_btree_test/fast

#=============================================================================
# Target rules for targets named btree_bench

# Build rule for target.
btree_bench: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 btree_bench
.PHONY : btree_bench

# fast build rule for target.
btree_bench/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_bench.dir/build.make CMakeFiles/btree_bench.dir/build
.PHONY : btree_bench/fast

btree_bench.o: btree_bench.cc.o
.PHONY : btree_bench.o

# target to build an object file
btree_bench.cc.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_bench.dir/build.make CMakeFiles/btree_bench.dir/btree_bench.cc.o
.PHONY : btree_bench.cc.o

btree_bench.i: btree_bench.cc.i
.PHONY : btree_bench.i

# target to preprocess a source file
btree_bench.cc.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_bench.dir/build.make CMakeFiles/btree_bench.dir/btree_bench.cc.i
.PHONY : btree_bench.cc.i

btree_bench.s: btree_bench.cc.s
.PHONY : btree_bench.s

# target to generate assembly for a file
btree_bench.cc.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_bench.dir/build.make CMakeFiles/btree_bench.dir/btree_bench.cc.s
.PHONY : btree_bench.cc.s

btree_test.o: btree_test.cc.o
.PHONY : btree_test.o

# target to build an object file
btree_test.cc.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_test.dir/build.make CMakeFiles/btree_test.dir/btree_test.cc.o
.PHONY : btree_test.cc.o

btree_test.i: btree_test.cc.i
.PHONY : btree_test.i

# target to preprocess a source file
btree_test.cc.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_test.dir/build.make CMakeFiles/btree_test.dir/btree_test.cc.i
.PHONY : btree_test.cc.i

btree_test.s: btree_test.cc.s
.PHONY : btree_test.s

# target to generate assembly for a file
btree_test.cc.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_test.dir/build.make CMakeFiles/btree_test.dir/btree_test.cc.s
.PHONY : btree_test.cc.s

btree_test_flags.o: btree_test_flags.cc.o
.PHONY : btree_test_flags.o

# target to build an object file
btree_test_flags.cc.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_test.dir/build.make CMakeFiles/btree_test.dir/btree_test_flags.cc.o
	$(MAKE) $(MAKESILENT) -f CMakeFiles/safe_btree_test.dir/build.make CMakeFiles/safe_btree_test.dir/btree_test_flags.cc.o
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_bench.dir/build.make CMakeFiles/btree_bench.dir/btree_test_flags.cc.o
.PHONY : btree_test_flags.cc.o

btree_test_flags.i: btree_test_flags.cc.i
.PHONY : btree_test_flags.i

# target to preprocess a source file
btree_test_flags.cc.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_test.dir/build.make CMakeFiles/btree_test.dir/btree_test_flags.cc.i
	$(MAKE) $(MAKESILENT) -f CMakeFiles/safe_btree_test.dir/build.make CMakeFiles/safe_btree_test.dir/btree_test_flags.cc.i
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_bench.dir/build.make CMakeFiles/btree_bench.dir/btree_test_flags.cc.i
.PHONY : btree_test_flags.cc.i

btree_test_flags.s: btree_test_flags.cc.s
.PHONY : btree_test_flags.s

# target to generate assembly for a file
btree_test_flags.cc.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_test.dir/build.make CMakeFiles/btree_test.dir/btree_test_flags.cc.s
	$(MAKE) $(MAKESILENT) -f CMakeFiles/safe_btree_test.dir/build.make CMakeFiles/safe_btree_test.dir/btree_test_flags.cc.s
	$(MAKE) $(MAKESILENT) -f CMakeFiles/btree_bench.dir/build.make CMakeFiles/btree_bench.dir/btree_test_flags.cc.s
.PHONY : btree_test_flags.cc.s

safe_btree_test.o: safe_btree_test.cc.o
.PHONY : safe_btree_test.o

# target to build an object file
safe_btree_test.cc.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/safe_btree_test.dir/build.make CMakeFiles/safe_btree_test.dir/safe_btree_test.cc.o
.PHONY : safe_btree_test.cc.o

safe_btree_test.i: safe_btree_test.cc.i
.PHONY : safe_btree_test.i

# target to preprocess a source file
safe_btree_test.cc.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/safe_btree_test.dir/build.make CMakeFiles/safe_btree_test.dir/safe_btree_test.cc.i
.PHONY : safe_btree_test.cc.i

safe_btree_test.s: safe_btree_test.cc.s
.PHONY : safe_btree_test.s

# target to generate assembly for a file
safe_btree_test.cc.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/safe_btree_test.dir/build.make CMakeFiles/safe_btree_test.dir/safe_btree_test.cc.s
.PHONY : safe_btree_test.cc.s

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... edit_cache"
	@echo "... rebuild_cache"
	@echo "... test"
	@echo "... btree_bench"
	@echo "... btree_test"
	@echo "... safe_btree_test"
	@echo "... btree_bench.o"
	@echo "... btree_bench.i"
	@echo "... btree_bench.s"
	@echo "... btree_test.o"
	@echo "... btree_test.i"
	@echo "... btree_test.s"
	@echo "... btree_test_flags.o"
	@echo "... btree_test_flags.i"
	@echo "... btree_test_flags.s"
	@echo "... safe_btree_test.o"
	@echo "... safe_btree_test.i"
	@echo "... safe_btree_test.s"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system

