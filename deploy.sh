#!/bin/bash

set -xe

docker pull $DOCKER_TAG
docker run -e "CF_HOME=/pong_matcher" -t $DOCKER_TAG /bin/bash -c "\
    cd pong_matcher
    cf api https://api.run.pivotal.io
    cf auth $CF_USERNAME $CF_PASSWORD &&
    cf target -o $CF_ORG -s $CF_SPACE &&
    cf push -n $HOSTNAME -d cfapps.io"
