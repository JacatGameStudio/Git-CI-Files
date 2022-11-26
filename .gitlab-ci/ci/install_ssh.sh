#!/bin/bash

mkdir -p ~/.ssh

which ssh-agent || ( apt-get update -y && apt-get install openssh-client git -y )
eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" | base64 --decode | ssh-add -

chmod 700 ~/.ssh

# echo "$SSH_SERVER_HOSTKEYS" > ~/.ssh/known_hosts
# chmod 644 ~/.ssh/known_hosts

ssh-keyscan github.com >> ~/.ssh/known_hosts
ssh-keyscan gitlab.volio.vn >> ~/.ssh/known_hosts
chmod 644 ~/.ssh/known_hosts

ssh-add -l -E sha256
ssh -vT git@github.com
