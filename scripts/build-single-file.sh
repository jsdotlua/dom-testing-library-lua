#!/bin/sh

set -e

mkdir -p build
mkdir -p build/debug

rm -f build/dom-testing-library.lua
rm -f build/debug/dom-testing-library.lua

darklua process --config .darklua-bundle.json src/init.lua build/dom-testing-library.lua
darklua process --config .darklua-bundle-dev.json src/init.lua build/debug/dom-testing-library.lua
