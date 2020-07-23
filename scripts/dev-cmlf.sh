#! /usr/bin/env bash

# Credits: https://github.com/tiangolo/full-stack-fastapi-postgresql/blob/master/scripts/dev-link.sh

# Exit in case of error
set -e

# Run this from the root of the project to generate a dev-link project
# It will contain a link to each of the files of the generator, except for
# .env and frontend/.env, that will be the generated ones
# This allows developing with a live stack while keeping the same source code
# Without having to generate dev-fsfp and integrating back all the files

PROJECT_NAME="Dev Link"
PROJECT_DIRECTORY=$(echo $PROJECT_NAME | awk '{print tolower($0)}' | awk  '{ gsub(" ","-",$0); print $0 }')

mkdir -p tmp-$PROJECT_DIRECTORY/frontend

rm -rf $PROJECT_DIRECTORY

cookiecutter --no-input -f ./ project_name="${PROJECT_NAME}"

mv ./$PROJECT_DIRECTORY/.env ./tmp-$PROJECT_DIRECTORY/
# mv ./$PROJECT_DIRECTORY/frontend/.env ./tmp-$PROJECT_DIRECTORY/frontend/

rm -rf ./$PROJECT_DIRECTORY/
mkdir -p ./$PROJECT_DIRECTORY/

cd ./$PROJECT_DIRECTORY/

for f in ../\{\{cookiecutter.project_slug\}\}/* ; do
    ln -s "$f" ./
done

cd ..

mv ./tmp-$PROJECT_DIRECTORY/.env ./$PROJECT_DIRECTORY/
# # mv ./tmp-$PROJECT_DIRECTORY/frontend/.env ./$PROJECT_DIRECTORY/frontend/

rm -rf ./tmp-$PROJECT_DIRECTORY