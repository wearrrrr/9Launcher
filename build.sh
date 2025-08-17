NPROC=$(nproc)
if [ "$NPROC" -lt 1 ]; then NPROC=1; fi

mkdir -p build
# -Wno-dev is here just because QT spits a ton of warnings with MMaterial, will fix it someday probably maybe.
cmake -B build -S . -Wno-dev -G Ninja
cd build
ninja -j$NPROC

if ([ -f 9Launcher ]); then
    strip 9Launcher
fi
