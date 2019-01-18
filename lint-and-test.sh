#!/bin/bash

set -e

BOLD='\e[1m'
NC='\033[0m'

function lint_files() {
    find modules/ -name '*.pp' | xargs puppet-lint \
        --with-filename \
        --fail-on-warnings
}

function test_modules() {
    for MODULE in $(ls modules); do
        echo -e "\nRunning tests for ${BOLD}${MODULE}${NC}"
        pushd modules/${MODULE} > /dev/null
        pdk test unit
        popd > /dev/null
    done
}

lint_files
test_modules

