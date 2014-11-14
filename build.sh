#!/bin/bash

set -ex

docker pull $DOCKER_TAG || true
docker build $DOCKER_BUILD_OPTS -t $DOCKER_TAG $DOCKER_DIR
docker push $DOCKER_TAG
