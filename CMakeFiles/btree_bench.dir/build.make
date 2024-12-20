# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

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

# Include any dependencies generated for this target.
include CMakeFiles/btree_bench.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/btree_bench.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/btree_bench.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/btree_bench.dir/flags.make

CMakeFiles/btree_bench.dir/btree_bench.cc.o: CMakeFiles/btree_bench.dir/flags.make
CMakeFiles/btree_bench.dir/btree_bench.cc.o: btree_bench.cc
CMakeFiles/btree_bench.dir/btree_bench.cc.o: CMakeFiles/btree_bench.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/cristian/cheridb_nocap/structures/google-btree/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/btree_bench.dir/btree_bench.cc.o"
	/usr/local64/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/btree_bench.dir/btree_bench.cc.o -MF CMakeFiles/btree_bench.dir/btree_bench.cc.o.d -o CMakeFiles/btree_bench.dir/btree_bench.cc.o -c /home/cristian/cheridb_nocap/structures/google-btree/btree_bench.cc

CMakeFiles/btree_bench.dir/btree_bench.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/btree_bench.dir/btree_bench.cc.i"
	/usr/local64/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/cristian/cheridb_nocap/structures/google-btree/btree_bench.cc > CMakeFiles/btree_bench.dir/btree_bench.cc.i

CMakeFiles/btree_bench.dir/btree_bench.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/btree_bench.dir/btree_bench.cc.s"
	/usr/local64/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/cristian/cheridb_nocap/structures/google-btree/btree_bench.cc -o CMakeFiles/btree_bench.dir/btree_bench.cc.s

CMakeFiles/btree_bench.dir/btree_test_flags.cc.o: CMakeFiles/btree_bench.dir/flags.make
CMakeFiles/btree_bench.dir/btree_test_flags.cc.o: btree_test_flags.cc
CMakeFiles/btree_bench.dir/btree_test_flags.cc.o: CMakeFiles/btree_bench.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/cristian/cheridb_nocap/structures/google-btree/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/btree_bench.dir/btree_test_flags.cc.o"
	/usr/local64/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/btree_bench.dir/btree_test_flags.cc.o -MF CMakeFiles/btree_bench.dir/btree_test_flags.cc.o.d -o CMakeFiles/btree_bench.dir/btree_test_flags.cc.o -c /home/cristian/cheridb_nocap/structures/google-btree/btree_test_flags.cc

CMakeFiles/btree_bench.dir/btree_test_flags.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/btree_bench.dir/btree_test_flags.cc.i"
	/usr/local64/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/cristian/cheridb_nocap/structures/google-btree/btree_test_flags.cc > CMakeFiles/btree_bench.dir/btree_test_flags.cc.i

CMakeFiles/btree_bench.dir/btree_test_flags.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/btree_bench.dir/btree_test_flags.cc.s"
	/usr/local64/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/cristian/cheridb_nocap/structures/google-btree/btree_test_flags.cc -o CMakeFiles/btree_bench.dir/btree_test_flags.cc.s

# Object files for target btree_bench
btree_bench_OBJECTS = \
"CMakeFiles/btree_bench.dir/btree_bench.cc.o" \
"CMakeFiles/btree_bench.dir/btree_test_flags.cc.o"

# External object files for target btree_bench
btree_bench_EXTERNAL_OBJECTS =

btree_bench: CMakeFiles/btree_bench.dir/btree_bench.cc.o
btree_bench: CMakeFiles/btree_bench.dir/btree_test_flags.cc.o
btree_bench: CMakeFiles/btree_bench.dir/build.make
btree_bench: CMakeFiles/btree_bench.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/cristian/cheridb_nocap/structures/google-btree/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable btree_bench"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/btree_bench.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/btree_bench.dir/build: btree_bench
.PHONY : CMakeFiles/btree_bench.dir/build

CMakeFiles/btree_bench.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/btree_bench.dir/cmake_clean.cmake
.PHONY : CMakeFiles/btree_bench.dir/clean

CMakeFiles/btree_bench.dir/depend:
	cd /home/cristian/cheridb_nocap/structures/google-btree && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/cristian/cheridb_nocap/structures/google-btree /home/cristian/cheridb_nocap/structures/google-btree /home/cristian/cheridb_nocap/structures/google-btree /home/cristian/cheridb_nocap/structures/google-btree /home/cristian/cheridb_nocap/structures/google-btree/CMakeFiles/btree_bench.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/btree_bench.dir/depend

