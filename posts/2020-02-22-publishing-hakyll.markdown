---
title: "[Discovery] A conveniant setup with hakyll on github"
---

## Maybe a bash script is good enough?

```bash
#!/bin/bash
stack exec dz build
git add -A
git commit -m "$1"
git push origin -u HEAD
git checkout master
cp -a _site/. .
git add -A
git commit -m "Publish $2"
git push origin -u HEAD
```

Happy path for days! I don't like it but it kind of works.

Some guards should help.

```bash
#!/bin/bash

set -axe

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
  echo 1>&2 "Usage: $0 <develop message> <publish message>"
  exit 3
fi

stack clean
stack build
stack exec dz clean
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
```