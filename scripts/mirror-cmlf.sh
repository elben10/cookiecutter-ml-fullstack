#! /usr/bin/env bash

# Credits: https://github.com/tiangolo/full-stack-fastapi-postgresql/blob/master/scripts/dev-link.sh

# Exit in case of error
set -e

PROJECT_NAME="Mirror CMLF"
PROJECT_DIRECTORY=$(echo $PROJECT_NAME | awk '{print tolower($0)}' | awk  '{ gsub(" ","-",$0); print $0 }')

mkdir -p tmp-$PROJECT_DIRECTORY
if [ -d "$PROJECT_DIRECTORY/.git" ]; then rsync -r $PROJECT_DIRECTORY/.git/ tmp-$PROJECT_DIRECTORY/.git/; fi
rm -rf $PROJECT_DIRECTORY
cookiecutter --no-input -f ./ project_name="${PROJECT_NAME}"
if [ -d "tmp-$PROJECT_DIRECTORY/.git" ]; then rsync -r tmp-$PROJECT_DIRECTORY/.git/ $PROJECT_DIRECTORY/.git/; fi
rm -rf ./tmp-$PROJECT_DIRECTORY