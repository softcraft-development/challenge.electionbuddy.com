#!/bin/bash

docker build -t electionbuddy-challenge .
docker run -it -p 3000:3000 electionbuddy-challenge bundle exec rails server -b 0.0.0.0