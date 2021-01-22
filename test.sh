#!/bin/bash

docker build -t electionbuddy-challenge .
docker run electionbuddy-challenge bundle exec rake test