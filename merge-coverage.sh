#!/usr/bin/env bash

relPath="$(echo `pwd` | sed "s/$MELOS_ROOT_PATH\///g" | sed 's/\//\\\//g')"

if [ -f "pubspec.yaml" ]; then
  if [ -d "coverage" ]; then
    if [ ! -d "$MELOS_ROOT_PATH/coverage" ]; then
      mkdir "$MELOS_ROOT_PATH/coverage"
    fi
    sed "s/^SF:lib/SF:$relPath\/lib/g" coverage/lcov.info >> "$MELOS_ROOT_PATH/coverage/lcov.info"
  fi
fi