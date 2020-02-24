---
title: "[Discovery] A conveniant setup with hakyll on github"
---

## Maybe a bash script is good enough?

```bash
#!/bin/bash
stack exec dz build
git add -A
git commit -m $1
git push origin -u HEAD
git checkout master
cp -a _site/. .
git add -A
git commit -m "Publish $1"
git push origin -u HEAD
```