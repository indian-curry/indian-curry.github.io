#!/bin/bash

# Temporarily store uncommited changes
git stash

# Verify correct branch
git checkout develop

# Build new files
stack exec website clean
stack exec website build

# Get previous files
git fetch --all origin
git checkout -b master --track origin/master

# Overwrite existing files with new files
rsync -a --ignore-times --filter='P _site/' --filter='P .travis.yml' --filter='P _cache/' --filter='P .git/' --filter='P .stack-work' --filter='P .gitignore' --delete-excluded _site/  .

# Commit
git add -A
git commit --no-verify -m "Publish."

# Push
git push origin master:master

# Restoration
git checkout develop
git branch -D master
git stash pop
