#!/usr/bin/env bash

CONTAINER_NAME=$1

if [[ -z ${CONTAINER_NAME} ]]; then
    echo "Please provide a container name"
    echo "E.g. ${0} my_cool_container"
    exit 1
fi

# Stop old docker containers
docker stop ${CONTAINER_NAME}

# Remove old docker containers
docker container rm ${CONTAINER_NAME}