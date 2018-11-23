#!/bin/bash

set -e

function lint_files() {
    find modules/ -name '*.pp' | xargs puppet-lint \
        --with-filename \
        --fail-on-warnings
}

function test_modules() {
    for MODULE in $(ls modules); do
        echo "Running tests for ${MODULE}"
        pushd modules/${MODULE}
        pdk test unit
        popd
    done
}

lint_files
test_modules

