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

# ruby-install
ADD     https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz ruby-install-0.4.3.tar.gz
RUN     tar -zxf ruby-install-0.4.3.tar.gz
RUN     cd ruby-install-0.4.3; make install

# ruby
RUN     ruby-install ruby 2.1.5 -- --disable-install-doc
RUN     chown -R web:web /opt/rubies/ruby-2.1.5

# mysql
RUN     apt-get install -qq mysql-server
RUN     apt-get install -qq libmysqlclient-dev

# install app
ADD     app pong_matcher
RUN     chown -R web:web /pong_matcher

# become unprivileged
USER    web

# install bundler
ENV     PATH /opt/rubies/ruby-2.1.5/bin:$PATH
RUN     echo "gem: --no-document" >> /home/web/.gemrc
RUN     gem install bundler

# run tests as part of build - should fail if tests fail
WORKDIR /pong_matcher
RUN     bundle
USER    root
RUN     service mysql start && su web -c 'PATH=/opt/rubies/ruby-2.1.5/bin:$PATH bin/rake db:create db:migrate test:prepare test'
