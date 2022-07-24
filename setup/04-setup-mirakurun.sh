#!/bin/bash

# Node.js v16のインストール
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# PM2のインストール
sudo npm install pm2 --location=global
sudo pm2 startup

# Mirakurunのインストール
sudo npm install mirakurun@3.8.1 --location=global --production
sudo mirakurun init

# v3.8.1を経由しないと3.9.xに上げられない
sudo npm install mirakurun --location=global --production
sudo mirakurun restart

# Node.jsのバージョン確認
echo -n "*** Node.js Version: "
node -v

# npmのバージョン確認
echo -n "*** npm Version: "
npm -v

# PM2のバージョン確認
echo "*** pm2 Version: "
pm2 -v

# Mirakurunのバージョン確認
echo "*** Mirakurun Version: "
sudo mirakurun version
