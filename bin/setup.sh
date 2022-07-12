#!/bin/bash
# setup.sh
# @ param = api_server_url

REPO_DIR=/home/ubuntu/team1-imageboard-front
NGINX_SITES_AVAILABLE=/etc/nginx/sites-available
NGINX_SITES_ENABLED=/etc/nginx/sites-enabled

sudo systemctl stop nginx

echo "==========================================="
echo "1. Install Dependency"
echo "==========================================="
sudo apt-get update
sudo apt-get install nginx git npm -y


echo "==========================================="
echo "2. Node Update"
echo "==========================================="
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install v16
echo "***  Node Version ***"
node --version


echo "==========================================="
echo "3. Repository check, Git pull"
echo "==========================================="
[ -d "$REPO_DIR" ] || git clone https://github.com/BiBimBapXOpenStack/team1-imageboard-front.git 
cd $REPO_DIR
rm -rf .git/index.lock
git fetch --all
git reset --hard origin/develop
git pull origin develop


echo "==========================================="
echo "4. Nginx Configuration"
echo "==========================================="
[ -f "$NGINX_SITES_AVAILABLE"/default ] && sudo rm $NGINX_SITES_AVAILABLE/default
[ -f "$NGINX_SITES_ENABLED"/default ] && sudo rm $NGINX_SITES_ENABLED/default
cd $REPO_DIR/bin/conf;
sudo sed -i 's@SERVER_URL@'"$1"'@g' imageboard.conf
[ -f "$NGINX_SITES_AVAILABLE"/imageboard.conf ] && sudo rm $NGINX_SITES_AVAILABLE/imageboard.conf
sudo cp imageboard.conf $NGINX_SITES_AVAILABLE/imageboard.conf
echo "*** sites-available/imageboard.conf ***"
sudo cat $NGINX_SITES_AVAILABLE/imageboard.conf
cd ~
[ -f "$NGINX_SITES_ENABLED"/imageboard.conf ] && sudo rm $NGINX_SITES_ENABLED/imageboard.conf
sudo ln -s $NGINX_SITES_AVAILABLE/imageboard.conf $NGINX_SITES_ENABLED/imageboard.conf
echo "*** sites-enabled/imageboard.conf ***"
sudo cat $NGINX_SITES_ENABLED/imageboard.conf


echo "==========================================="
echo "5. React env configuration"
echo "==========================================="
cd $REPO_DIR
[ -f .env ] && rm .env
sudo echo REACT_APP_HTTP_URL=$1 >> .env
echo "*** team1-imageboard-front/.env ***"
sudo cat .env


echo "==========================================="
echo "6. Build"
echo "==========================================="
cd $REPO_DIR
[ -d build ] && rm -rf build
[ -d node_modules ] && rm -rf node_modules
[ -f package-lock.json ] && rm -rf package-lock.json
npm install
npm run build
echo "*** team1-imageboard-front/build/ ***"
cd build/
ls

sudo systemctl start nginx
