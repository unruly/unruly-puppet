#!/usr/bin/env bash

CLASS_TO_IMPORT=$1
IMAGE_NAME=${2:-image}
CONTAINER_NAME=${IMAGE_NAME}_container

if [[ -z ${CLASS_TO_IMPORT} ]]; then
    echo "Please provide a class name"
    echo "E.g. ${0} monitoring"
    exit 1
fi

#Build docker image
echo -e "\n========== BUILDING =========\n"
docker build -t ${IMAGE_NAME} .

# Start docker container
echo -e "\n========== RUNNING =========\n"
# First run systemd (Dockerfile CMD takes care of this)
docker run --rm -d --privileged=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name ${CONTAINER_NAME} ${IMAGE_NAME}
# Then run puppet
docker exec -t ${CONTAINER_NAME} /bin/sh -c "/opt/puppetlabs/bin/puppet apply --detailed-exitcodes --modulepath /puppet/modules/ -e 'include ${CLASS_TO_IMPORT}'"
DOCKER_EXIT_CODE=$?

echo "${CONTAINER_NAME} exited with code ${DOCKER_EXIT_CODE}."

if [[ ${DOCKER_EXIT_CODE} -eq 2 ]]; then
  GREEN='\033[0;32m'
  NC='\033[0m' # No Color
  printf "${GREEN}Manifests applied without errors.${NC}\n"
fi

# Stop the container
docker stop ${CONTAINER_NAME} > /dev/null
# Remove all untagged images (i.e. everything except the 'latest' image)
docker rmi $(docker images | grep "^<none>" | awk '{print $3}') 2>&1 > /dev/null