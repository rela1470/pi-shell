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

# 削除対象の拡張子
FILE_TYPE="m2ts"

# 指定した日数より古いものを削除対象とします
DELETE_DAY="90"

# 以下処理
echo Start deleting.
TS_LIST=$(find ${RECORDED_DIR} -name "*.${FILE_TYPE}" -mtime +${DELETE_DAY} -printf "%f\n")
for TS_FILE in ${TS_LIST}; do
    # MP4ファイルが作成されてなかったら削除しない
    MP4_FILE="${MP4_DIR}${TS_FILE%*.}.mp4"
    if [ ! -e ${MP4_FILE} ]; then
        continue
    fi

    rm ${RECORDED_DIR}${TS_FILE}
done
echo Finished deleting.
