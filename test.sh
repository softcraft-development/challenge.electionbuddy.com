#!/bin/bash

docker build -t electionbuddy-challenge .
docker run -it electionbuddy-challenge bundle exec rake test