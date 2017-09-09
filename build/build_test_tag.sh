#!/bin/bash
set -e -o pipefail

project="liquibase-sqlite"
dockerhub_user="kilna"
latest_version=$(tail -1 build/versions.txt)
version="${1:-$latest_version}"

header() { printf '=%.0s' {1..79}; echo; echo $@; printf '=%.0s' {1..79}; echo; }

echo "jdbc_driver_version=$version" > .env

header "Testing $project $version"
docker-compose -f docker-compose.test.yml down --rmi all &>/dev/null || true
docker-compose -f docker-compose.test.yml up --exit-code-from sut --build --build-arg jdbc_driver_version="$version" --force-recreate --remove-orphans
docker-compose -f docker-compose.test.yml down --rmi all

header "Building $project $version"
docker build --tag "$project:build" --build-arg jdbc_driver_version="$version" .

header "Git Tagging $project $version"
git fetch -p origin
git remote prune origin
git pull
if [[ `git tag | grep -F "v$version"` != '' ]]; then
  git tag -d "v$version" || true
fi
git tag "v$version"
git push origin ":v$version" || git push origin "v$version"
git checkout .env

header "Docker Tagging and Pushing $project:$version"
docker tag "$project:build" "$dockerhub_user/$project:$version"
docker push "$dockerhub_user/$project:$version"

if [[ "$version" == "$latest_version" ]]; then
  header "Docker Tagging and Pushing $project:latest"
  docker tag "$project:build" "$dockerhub_user/$project:latest"
  docker push "$dockerhub_user/$project:latest"
fi

