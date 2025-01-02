#!/bin/sh
# install git first.
mkdir -p ~/org
git clone git@github.com:ret2pop/ret2pop-website ~/org/website
mkdir -p ~/src
git clone git@nullring.xyz:/var/git/publish-org-roam-ui ~/src
