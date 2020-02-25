#!/bin/bash

set -axe

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
  echo 1>&2 "Usage: $0 <develop message> <publish message>"
  exit 3
fi

stack exec dz build
git add -A
git commit -m "$1"
git push origin -u HEAD
if [ $? -eq 0 ]; then
  git checkout master
  cp -a _site/. .
  git add -A
  git commit -m "$2"
  git push origin -u HEAD
else
  echo 1>&2 "Did not push to develop, stopping."
  exit 3
fi