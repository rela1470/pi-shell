#!/bin/bash

# EPGStationのクローン
cd ~
git clone https://github.com/l3tnun/EPGStation.git
cd EPGStation

# EPGStationのインストール
npm run all-install
npm run build

# 設定ファイルのコピー
cp config/config.yml.template config/config.yml
cp config/operatorLogConfig.sample.yml config/operatorLogConfig.yml
cp config/epgUpdaterLogConfig.sample.yml config/epgUpdaterLogConfig.yml
cp config/serviceLogConfig.sample.yml config/serviceLogConfig.yml
cp config/enc.js.template config/enc.js

# PM2自動スタートアップへの登録
sudo pm2 start dist/index.js --name "epgstation"
sudo pm2 save

echo "Setup Finished."
