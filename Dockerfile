FROM ruby
MAINTAINER Joao Costa <joaocosta@zonalivre.org>

RUN mkdir /webapp
WORKDIR /webapp

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

ADD . /webapp

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
