#!/bin/bash

set -ex

docker_tag=docker.gocd.cf-app.com:5000/$APP_NAME
dir=$APP_NAME
cp -a ../app $dir/
docker pull $docker_tag || true
docker build $DOCKER_BUILD_OPTS -t $docker_tag $dir
docker push $DOCKER_TAG
