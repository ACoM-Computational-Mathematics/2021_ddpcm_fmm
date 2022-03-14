# Get ddX sources
git submodule update --init
# Create build folder
cd ddX
mkdir build
cd build
# Run CMake
cmake ..
# Compile everything
make
