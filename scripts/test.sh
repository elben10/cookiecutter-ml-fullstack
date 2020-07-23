#! /usr/bin/env bash

# Exit in case of error
set -e

rm -fr testing-project

poetry install

poetry run cookiecutter --no-input -f ./ project_name="Testing Project"

cd ./testing-project

bash ./scripts/test.sh "$@"

cd ../