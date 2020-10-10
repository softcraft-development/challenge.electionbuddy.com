FROM ruby:2.6.1
LABEL maintainer="bradyb@electionbuddy.com"

# Install required Ubuntu packages.
RUN apt-get update && \
  apt-get install -y curl git gnupg apt-transport-https ca-certificates

# Need a JS runtime for asset compilation.
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo 'deb https://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && \
  apt-get install -y nodejs yarn

RUN useradd --create-home --shell /bin/bash app
COPY --chown=app:app .ruby-version Gemfile Gemfile.lock /home/app/challenge.electionbuddy.com/

WORKDIR /home/app/challenge.electionbuddy.com
RUN rm -rf ./.git
RUN rm -rf ./working

RUN yes | gem uninstall bundler --all && \
  export BUNDLER_VERSION=$(cat Gemfile.lock | tail -1 | tr -d " ") && \
  gem install bundler -v "$BUNDLER_VERSION"

USER app

# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN bundle config set deployment 'true'
RUN bundle install

COPY --chown=app:app . /home/app/challenge.electionbuddy.com/

RUN bundle exec rake assets:precompile

# Back to root for start.
USER root
