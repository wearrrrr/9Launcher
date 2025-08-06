#!/bin/bash
./build.sh
if ([ -f bin/NineLauncher ]); then
    ./bin/NineLauncher
    else
    printf "\x1b[1;31mNineLauncher not found, build likely failed!\n"
fi
