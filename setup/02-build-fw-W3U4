# ホームディレクトリに移動
cd ~

# Gitからファームウェアツールをクローン
git clone https://github.com/nns779/px4_drv.git
cd px4_drv/fwtool

# ファームウェアツールのビルド
make

# PX-W3U4ドライバのダウンロード
wget http://plex-net.co.jp/download/pxw3u4v1.4.zip -O pxw3u4v1.4.zip

# PX-W3U4ドライバの解凍
unzip -oj pxw3u4v1.4.zip pxw3u4v1/x64/PXW3U4.sys

# ファームウェアの作成
./fwtool PXW3U4.sys it930x-firmware_pxw3u4.bin

# ファームウェアの配置
sudo mkdir -p /lib/firmware
sudo mv it930x-firmware_pxw3u4.bin /lib/firmware/it930x-firmware.bin

# クリーン
rm ./pxw3u4v1.4.zip
rm ./PXW3U4.sys

# ドライバのインストール
cd ../driver
make
sudo make install
sudo modprobe px4_drv

# 環境設定
cat /boot/cmdline.txt | grep coherent_pool=4M
if $? -ne 0 ; then
  echo -n `cat /boot/cmdline.txt` coherent_pool=4M > ./cmdline.txt
  sudo cp ./cmdline.txt /boot/cmdline.txt
  rm ./cmdline.txt
fi

cat /etc/modules | grep px4_drv
if $? -ne 0 ; then
  cat /etc/modules > ./modules
  echo px4_drv >> ./modules
  sudo cp ./modules /etc/modules
  rm ./modules
fi
