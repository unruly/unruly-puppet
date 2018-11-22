#!/usr/bin/env bash
set -e

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
docker build --no-cache -t ${IMAGE_NAME} .

#Start docker container
echo -e "\n========== RUNNING =========\n"
#First run systemd (Dockerfile CMD takes care of this)
docker run --rm -d --privileged=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name ${CONTAINER_NAME} ${IMAGE_NAME}
#Then run puppet
docker exec -t ${CONTAINER_NAME} /opt/puppetlabs/bin/puppet apply --modulepath /puppet/modules/ -e "include ${CLASS_TO_IMPORT}"

destroy_docker_container.sh ${CONTAINER_NAME}