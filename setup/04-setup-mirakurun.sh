#!/bin/bash

# Node.js v16のインストール
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# PM2のインストール
sudo npm install pm2 -g
sudo pm2 startup

# Mirakurunのインストール
sudo npm install mirakurun -g --unsafe-perm --foreground-scripts --production

# Node.jsのバージョン確認
node -v

# npmのバージョン確認
npm -v

# PM2のバージョン確認
pm2 -v

# Mirakurunのバージョン確認
sudo mirakurun version
