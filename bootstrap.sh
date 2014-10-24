#!/bin/bash

set -eu

brew update
brew install ansible
brew install vagrant

mkdir -p ./roles
ansible-galaxy --roles-path ./roles install -r requirements.txt

vagrant up jenkins

