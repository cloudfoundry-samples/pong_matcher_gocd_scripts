#!/bin/bash

set -xe

docker_tag=docker.gocd.cf-app.com:5000/$APP_NAME
cf_space=$APP_NAME
docker pull $docker_tag
docker run -e "CF_HOME=/pong_matcher" -t $docker_tag /bin/bash -c "\
    cd pong_matcher
    cf api https://api.run.pivotal.io
    cf auth $CF_USERNAME $CF_PASSWORD &&
    cf target -o $CF_ORG -s $cf_space &&
    cf push -n $APP_NAME -d cfapps.io"
