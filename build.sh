mkdir -p build
# -Wno-dev is here just because QT spits a ton of warnings with MMaterial, will fix it someday probably maybe. 
cmake -B build -S . -Wno-dev
cd build
make -j12