#!/bin/bash

REPO_DIR=/home/ubuntu/team1-imageboard-front

sudo systemctl stop nginx

echo "==========================================="
echo "1. Git pull"
echo "==========================================="
cd $REPO_DIR
git fetch --all
git reset --hard origin/develop
git pull origin develop

echo "==========================================="
echo "2. Install node"
echo "==========================================="
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install v16

echo "==========================================="
echo "3. Build"
echo "==========================================="
cd $REPO_DIR
[ -d build ] && rm -rf build
npm install
npm run build

sudo systemctl start nginx
