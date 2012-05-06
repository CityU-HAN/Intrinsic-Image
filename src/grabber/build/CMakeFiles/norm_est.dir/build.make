# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/austin/Documents/Normals

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/austin/Documents/Normals/build

# Include any dependencies generated for this target.
include CMakeFiles/norm_est.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/norm_est.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/norm_est.dir/flags.make

CMakeFiles/norm_est.dir/norm_est.cpp.o: CMakeFiles/norm_est.dir/flags.make
CMakeFiles/norm_est.dir/norm_est.cpp.o: ../norm_est.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/austin/Documents/Normals/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/norm_est.dir/norm_est.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/norm_est.dir/norm_est.cpp.o -c /home/austin/Documents/Normals/norm_est.cpp

CMakeFiles/norm_est.dir/norm_est.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/norm_est.dir/norm_est.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/austin/Documents/Normals/norm_est.cpp > CMakeFiles/norm_est.dir/norm_est.cpp.i

CMakeFiles/norm_est.dir/norm_est.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/norm_est.dir/norm_est.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/austin/Documents/Normals/norm_est.cpp -o CMakeFiles/norm_est.dir/norm_est.cpp.s

CMakeFiles/norm_est.dir/norm_est.cpp.o.requires:
.PHONY : CMakeFiles/norm_est.dir/norm_est.cpp.o.requires

CMakeFiles/norm_est.dir/norm_est.cpp.o.provides: CMakeFiles/norm_est.dir/norm_est.cpp.o.requires
	$(MAKE) -f CMakeFiles/norm_est.dir/build.make CMakeFiles/norm_est.dir/norm_est.cpp.o.provides.build
.PHONY : CMakeFiles/norm_est.dir/norm_est.cpp.o.provides

CMakeFiles/norm_est.dir/norm_est.cpp.o.provides.build: CMakeFiles/norm_est.dir/norm_est.cpp.o

# Object files for target norm_est
norm_est_OBJECTS = \
"CMakeFiles/norm_est.dir/norm_est.cpp.o"

# External object files for target norm_est
norm_est_EXTERNAL_OBJECTS =

norm_est: CMakeFiles/norm_est.dir/norm_est.cpp.o
norm_est: /usr/lib/libboost_system-mt.so
norm_est: /usr/lib/libboost_filesystem-mt.so
norm_est: /usr/lib/libboost_thread-mt.so
norm_est: /usr/lib/libboost_date_time-mt.so
norm_est: /usr/lib/libboost_iostreams-mt.so
norm_est: /usr/lib/libpcl_common.so
norm_est: /usr/lib/libpcl_octree.so
norm_est: /usr/lib/libOpenNI.so
norm_est: /usr/lib/libvtkCommon.so.5.8.0
norm_est: /usr/lib/libvtkRendering.so.5.8.0
norm_est: /usr/lib/libvtkHybrid.so.5.8.0
norm_est: /usr/lib/libpcl_io.so
norm_est: /usr/lib/libpcl_sample_consensus.so
norm_est: /usr/lib/libflann_cpp_s.a
norm_est: /usr/lib/libpcl_kdtree.so
norm_est: /usr/lib/libpcl_search.so
norm_est: /usr/lib/libpcl_features.so
norm_est: /usr/lib/libqhull.so
norm_est: /usr/lib/libpcl_surface.so
norm_est: /usr/lib/libpcl_segmentation.so
norm_est: /usr/lib/libpcl_filters.so
norm_est: /usr/lib/libpcl_tracking.so
norm_est: /usr/lib/libpcl_keypoints.so
norm_est: /usr/lib/libpcl_visualization.so
norm_est: /usr/lib/libpcl_registration.so
norm_est: /usr/lib/libpcl_apps.so
norm_est: /usr/lib/libvtkParallel.so.5.8.0
norm_est: /usr/lib/libvtkRendering.so.5.8.0
norm_est: /usr/lib/libvtkGraphics.so.5.8.0
norm_est: /usr/lib/libvtkImaging.so.5.8.0
norm_est: /usr/lib/libvtkIO.so.5.8.0
norm_est: /usr/lib/libvtkFiltering.so.5.8.0
norm_est: /usr/lib/libvtkCommon.so.5.8.0
norm_est: /usr/lib/libvtksys.so.5.8.0
norm_est: CMakeFiles/norm_est.dir/build.make
norm_est: CMakeFiles/norm_est.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable norm_est"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/norm_est.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/norm_est.dir/build: norm_est
.PHONY : CMakeFiles/norm_est.dir/build

CMakeFiles/norm_est.dir/requires: CMakeFiles/norm_est.dir/norm_est.cpp.o.requires
.PHONY : CMakeFiles/norm_est.dir/requires

CMakeFiles/norm_est.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/norm_est.dir/cmake_clean.cmake
.PHONY : CMakeFiles/norm_est.dir/clean

CMakeFiles/norm_est.dir/depend:
	cd /home/austin/Documents/Normals/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/austin/Documents/Normals /home/austin/Documents/Normals /home/austin/Documents/Normals/build /home/austin/Documents/Normals/build /home/austin/Documents/Normals/build/CMakeFiles/norm_est.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/norm_est.dir/depend
