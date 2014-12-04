# DOCKER-VERSION 1.2.0

# base
FROM    ubuntu:14.04
RUN     apt-get update
RUN     apt-get install -qy build-essential wget

# create user
RUN     adduser --disabled-password web

# cf
ADD     https://cli.run.pivotal.io/stable?release=debian64&source=github cf.deb
RUN     dpkg -i cf.deb

# install php
RUN     apt-get install -qq git
RUN     apt-get install -qq php5
RUN     apt-get install -qq curl

# install and test app as unprivileged user
ADD     app /pong_matcher
RUN     chown -R web:web /pong_matcher

USER    web
WORKDIR /pong_matcher
RUN     curl -sS https://getcomposer.org/installer | php
RUN     php composer.phar update
RUN     vendor/bin/phpunit test/

WORKDIR /
