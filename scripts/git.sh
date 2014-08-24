#!/bin/sh

# defines git up, which  syncs origin branches
git config --global alias.up '!git remote update -p; git merge --ff-only @{u}'
