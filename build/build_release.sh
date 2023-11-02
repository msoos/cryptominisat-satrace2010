rm -rf cmake* CMake* mtl Solver crypto*
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
make -j19
