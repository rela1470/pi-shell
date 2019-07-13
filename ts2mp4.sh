#====================================================#
#                                                    #
#         Copyright (c) 2019 K, Kijinosippo          #
#                                                    #
#    This code is released under the MIT License.    #
#   http://opensource.org/licenses/mit-license.php   #
#                                                    #
#====================================================#

# 録画データが保存されているフォルダを絶対パスで指定
RECORDED_DIR="/home/pi/chinachu/recorded/"

# エンコードしたデータを保存するフォルダを絶対パスで指定
MP4_DIR="/home/pi/chinachu/recorded/mp4/"

# エンコード対象の拡張子
ENC_TYPE="m2ts"

# FFmpegのコマンド。通常は変更しなくて良い。
FFMPEG_CMD="ffmpeg"

###########
# 以下処理
echo Start encoding.

# フォルダ作成
mkdir -p -v ${RECORDED_DIR}
mkdir -p -v ${MP4_DIR}
cd ${RECORDED_DIR}

# 対象フォルダ配下の全てのファイルパスを取得
for VIDEO_PATH in ${RECORDED_DIR}*; do
    # 変換元ファイル名
    VIDEO_FILE=$(basename ${VIDEO_PATH})
    
    # 変換後ファイル名
    MP4_FILE="${MP4_DIR}${VIDEO_FILE%.*}.mp4"
    
    # ファイル拡張子
    FILE_TYPE="${VIDEO_FILE##*.}"

    # エンコード対象拡張子かつMP4ファイルが未作成の場合エンコード
    if [ ${FILE_TYPE} = ${ENC_TYPE} ] && [ ! -e ${MP4_FILE} ]; then
        ${FFMPEG_CMD} -y -i ${RECORDED_DIR}${VIDEO_FILE} -vcodec h264_omx -b:v 6000k -vf pullup -r 24000/1001 -vsync 1 -qmin 10 -qmax 51 -qdiff 8 -i_qfactor 1.40 -qcomp 0.6 ${MP4_FILE}
    fi
done
echo Finished encoding.
