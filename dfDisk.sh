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

# リプライ先（空欄でも可能）
RE=""

# twit.jsのパス
TWIT_JS="/home/pi/chinachu/twit.js"

# 以下処理
CSV=$(df ${RECORDED_DIR} -h | tail -n 1 | tr -s " " ,)
DISK_SPACE=$(echo ${CSV}| cut -d , -f 4)
USED_PERCENT=$(echo ${CSV}| cut -d , -f 5)
node ${TWIT_JS} "${RE}Disk使用率は${USED_PERCENT}です。空き容量は${DISK_SPACE}です。"
