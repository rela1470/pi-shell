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

# 以下処理
cd ${RECORDED_DIR}
for VIDEO_PATH in ${RECORDED_DIR}*; do
    VIDEO_FILE=$(basename ${VIDEO_PATH})
    FILE_TYPE="${VIDEO_FILE##*.}"
    MP4_FILE="${MP4_DIR}${VIDEO_FILE}.mp4"

    if [ ${FILE_TYPE} = ${ENC_TYPE} ] && [ ! -e ${MP4_FILE} ]; then
        ${FFMPEG_CMD} -y -i ${RECORDED_DIR}${VIDEO_FILE} -vcodec h264_omx -b:v 6000k -vf pullup -r 24000/1001 -vsync 1 -qmin 10 -qmax 51 -qdiff 8 -i_qfactor 1.40 -qcomp 0.6 ${MP4_FILE}
    fi
done
