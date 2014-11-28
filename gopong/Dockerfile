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

# install mysql
RUN     apt-get install -qq mysql-server

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
ADD     app /home/web/go/src/github.com/camelpunch/pong_matcher_go
RUN     chown -R web:web /home/web/go/src
RUN     ln -s /home/web/go/src/github.com/camelpunch/pong_matcher_go /pong_matcher

USER    web
WORKDIR /home/web/go/src/github.com/camelpunch/pong_matcher_go
ENV     PATH $PATH:/home/web/go/bin
RUN     godep restore

USER    root
RUN     service mysql start &&\
        echo "CREATE DATABASE pong_matcher_go_test;" | mysql -u root &&\
        echo "GRANT ALL ON pong_matcher_go_test.* TO 'gopong'@'localhost' IDENTIFIED BY 'gopong';" | mysql -u root &&\
	su -c "go test -v ./... -ginkgo.noColor" web

USER    web
WORKDIR /
