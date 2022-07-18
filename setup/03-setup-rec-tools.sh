# libarib25のダウンロード
cd ~
wget --no-check-certificate https://github.com/stz2012/libarib25/archive/master.zip -O ./libarib25.zip

# libarib25の解凍
unzip -o libarib25.zip

# libarib25のビルドとインストール
cd libarib25-master
cmake .
make
make install

# recpt1のダウンロード
cd ~
wget --no-check-certificate https://github.com/stz2012/recpt1/archive/master.zip -O ./recpt1.zip

# recpt1の解凍
unzip -o recpt1.zip

# recpt1のビルドとインストール
cd recpt1-master/recpt1
./autogen.sh
./configure --enable-b25
make
make install

# 不要ファイルの削除
cd ~
rm ./libarib25.zip
rm -rf libarib25-master
rm ./recpt1.zip
rm -rf recpt1-master
