#!/bin/sh

set -e

./scripts/build-roblox-model.sh
./scripts/build-wally-package.sh
# bundling currently stack overflows, re-enable when full-moon
# re-write is published and updated in darklua
# ./scripts/build-single-file.sh
