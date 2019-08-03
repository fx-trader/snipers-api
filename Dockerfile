FROM ruby
MAINTAINER Joao Costa <joaocosta@zonalivre.org>

RUN mkdir /webapp
WORKDIR /webapp

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

ADD . /webapp
