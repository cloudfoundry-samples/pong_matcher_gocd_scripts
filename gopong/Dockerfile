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

# install golang
ADD     https://godeb.s3.amazonaws.com/godeb-amd64.tar.gz godeb.tar.gz
RUN     tar -zxf godeb.tar.gz
RUN     ./godeb install 1.3.3
RUN     apt-get install -qq git mercurial

# install and test app as unprivileged user
USER    web
ENV     GOPATH /home/web/go
RUN     mkdir -p /home/web/go/src
RUN     go get github.com/tools/godep

USER    root
ADD     app /home/web/go/src/pong_matcher_go
RUN     chown -R web:web /home/web/go/src/pong_matcher_go
RUN     ln -s /home/web/go/src/pong_matcher_go /pong_matcher

USER    web
WORKDIR /home/web/go/src/pong_matcher_go
ENV     PATH $PATH:/home/web/go/bin
RUN 	godep restore
RUN     go get github.com/onsi/ginkgo/ginkgo
RUN     ginkgo -noColor
WORKDIR /
