#! /usr/bin/env bash

# Exit in case of error
set -e

docker-compose \
    -f docker-compose.yml \
    config > docker-stack.yml

docker-compose -f docker-stack.yml build
docker-compose -f docker-stack.yml down -v --remove-orphans
docker-compose -f docker-stack.yml up -d
docker-compose -f docker-stack.yml down -v --remove-orphans