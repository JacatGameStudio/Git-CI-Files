#!/usr/bin/env bash

mkdir -p /root/.ssh

which ssh-agent || ( apt-get update -y && apt-get install openssh-client git -y )
eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" | base64 --decode | ssh-add -

chmod 700 /root/.ssh

# echo "$SSH_SERVER_HOSTKEYS" > /root/.ssh/known_hosts
# chmod 644 /root/.ssh/known_hosts

ssh-keyscan github.com >> ~/.ssh/known_hosts
ssh-keyscan gitlab.volio.vn >> ~/.ssh/known_hosts
chmod 644 ~/.ssh/known_hosts

ssh-add -l -E sha256
ssh -T git@github.com
