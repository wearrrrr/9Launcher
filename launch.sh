#!/bin/bash
rm bin/9Launcher
./build.sh $@
if ([ -f bin/9Launcher ]); then
    ./bin/9Launcher
    else
    printf "\x1b[1;31mNineLauncher not found, build likely failed!\n"
fi
