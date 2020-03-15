#!/bin/bash
if [ "$1" = "--all" ]; then
  for f in *_test.nim; do
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:../libs/ nim c -o:"bin/$f" -r "$f"
  done
else
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:../libs/ nim c -o:"bin/$1" -r "$1" 
fi

