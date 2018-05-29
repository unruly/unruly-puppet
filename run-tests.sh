#!/bin/bash

for MODULE in $(ls modules); do
  echo "Running tests for ${MODULE}"
  pushd modules/${MODULE}
  pdk test unit
  popd
done

