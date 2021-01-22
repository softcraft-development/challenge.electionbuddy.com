FROM ruby:3.0.0
LABEL maintainer="bradyb@electionbuddy.com"

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && \
  apt-get install -y nodejs build-essential
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install yarn

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

COPY . /home/app/

RUN bundle exec rake assets:precompile