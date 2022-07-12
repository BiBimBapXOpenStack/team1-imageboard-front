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
echo "2. Build"
echo "==========================================="
cd $REPO_DIR
[ -d build ] && rm -rf build
npm install
npm run build

sudo systemctl start nginx
