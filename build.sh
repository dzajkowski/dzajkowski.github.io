#!/bin/bash
stack exec dz build
git add -A
git commit -m $1
git push origin -u HEAD
git checkout master
cp -a _site/. .
git add -A
git commit -m "Publish $2"
git push origin -u HEAD