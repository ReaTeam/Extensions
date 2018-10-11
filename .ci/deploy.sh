#!/bin/sh

set -e

cd "$(dirname "$0")"

echo $DEPLOY_KEY_PASSPHRASE | gpg --batch --passphrase-fd 0 deploy_key.gpg

eval "$(ssh-agent -s)"
chmod 600 deploy_key
ssh-add deploy_key

git config push.default simple
git config user.name 'ReaTeam Bot'
git config user.email 'reateam-bot@cfillion.ca'
git remote add deploy 'git@github.com:ReaTeam/Extensions.git'

reapack-index --commit

git push deploy "$APPVEYOR_REPO_BRANCH"
