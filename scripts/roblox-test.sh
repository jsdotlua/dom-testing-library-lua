#!/bin/sh

set -xe

if [ ! -d node_modules ]; then
    rm -rf roblox
    yarn install
    yarn prepare
fi

if [ -d "roblox" ]; then
    ls -d roblox/* | grep -v node_modules | xargs rm -rf
fi

rojo sourcemap test-place.project.json -o sourcemap.json

darklua process src roblox/src
darklua process tests roblox/tests
darklua process node_modules roblox/node_modules

cp test-place.project.json roblox/

rojo build roblox/test-place.project.json -o place.rbxl

run-in-roblox --place place.rbxl --script roblox/tests/roblox-test.server.lua
