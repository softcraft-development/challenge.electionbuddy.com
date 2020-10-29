FROM ruby:2.7.1
LABEL maintainer="bradyb@electionbuddy.com"

# Install required Ubuntu packages.
RUN apt-get update && \
  apt-get install -y nodejs yarn

WORKDIR /home/app
COPY .ruby-version Gemfile Gemfile.lock /home/app/
RUN rm -rf ./.git
RUN rm -rf ./working

RUN yes | gem uninstall bundler --all && \
  export BUNDLER_VERSION=$(cat Gemfile.lock | tail -1 | tr -d " ") && \
  gem install bundler -v "$BUNDLER_VERSION"

RUN bundle config --global frozen 1 && \
  bundle config set deployment 'true' && \
  bundle install

COPY . /home/app/challenge.electionbuddy.com/

RUN bundle exec rake assets:precompile