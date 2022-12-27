#!/bin/bash

# ホームディレクトリに移動
cd ~

# Gitからファームウェアツールをクローン
git clone https://github.com/nns779/px4_drv.git
cd px4_drv/fwtool

# ファームウェアツールのビルド
make

# DTV02A-4TS-Pドライバのダウンロード
wget https://ukachi.jp/e-better/download_file/202108-DTV02A-4TS-P.zip -O DTV02A-4TS-P.zip

# DTV02A-4TS-Pドライバの解凍
unzip -oj DTV02A-4TS-P.zip 202108-DTV02A-4TS-P/Driver/x64/ISDB6014.sys

# ファームウェアの作成
./fwtool ISDB6014.sys it930x-firmware_4tsp.bin

# ファームウェアの配置
sudo mkdir -p /lib/firmware
sudo mv it930x-firmware_4tsp.bin /lib/firmware/it930x-firmware.bin

# クリーン
rm ./DTV02A-4TS-P.zip
rm ./ISDB6014.sys

# ドライバのインストール
cd ../driver
make
sudo make install
sudo modprobe px4_drv

# 環境設定
cat /boot/cmdline.txt | grep coherent_pool=4M
if [ "$?" -ne "0" ]; then
  echo -n `cat /boot/cmdline.txt` coherent_pool=4M > ./cmdline.txt
  sudo cp ./cmdline.txt /boot/cmdline.txt
  rm ./cmdline.txt
fi

cat /etc/modules | grep px4_drv
if [ "$?" -ne "0" ]; then
  cat /etc/modules > ./modules
  echo px4_drv >> ./modules
  sudo cp ./modules /etc/modules
  rm ./modules
fi

echo "Setup Finished."
