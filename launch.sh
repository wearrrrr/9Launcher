#!/bin/bash
./build.sh
if ([ -f build/NineLauncher ]); then
    ./build/NineLauncher
    else
    printf "\x1b[1;31mNineLauncher not found, build likely failed!\n"
fi