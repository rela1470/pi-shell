#====================================================#
#                                                    #
#         Copyright (c) 2019 K, Kijinosippo          #
#                                                    #
#    This code is released under the MIT License.    #
#   http://opensource.org/licenses/mit-license.php   #
#                                                    #
#====================================================#

# chinachuAPIアドレス
FQDN_OR_IP="127.0.0.1"
PORT="10772"
API_BASE="/api"
API_ENDPOINT="/reserves.json"

# BASIC認証を行うか
IS_BASIC=0
USER="user"
PASSWORD="password"

# 何時間後まで取得するか
RANGE=24

# リプライ先（空欄でも可能）
RE=""

# twit.jsのパス
TWIT_JS="/home/pi/chinachu/twit.js"

# 以下処理
echo Start process.
URL="http://${FQDN_OR_IP}:${PORT}${API_BASE}${API_ENDPOINT}"
if [ ${IS_BASIC} -eq 1 ]; then
    URL="http://${USER}:${PASSWORD}@${FQDN_OR_IP}:${PORT}${API_BASE}${API_ENDPOINT}"
fi
TIME=$(date +%s)
RESERVES=$(curl -s ${URL})
RESERVES_LENGTH=$(echo $RESERVES | jq length)
TWEET=""

for i in $(seq 0 $((${RESERVES_LENGTH} - 1))); do
    ITEM=$(echo ${RESERVES} | jq .[$i])
    START=$(echo ${ITEM} | jq .start)
    DELTA_SEC=$(($((${START} / 1000)) - $(date +%s)))
    DELTA=$((${DELTA_SEC} / 3600))

    if [ ${DELTA} -lt ${RANGE} ]; then
        START_STR=$(date -d @$(($START / 1000)) +%H:%M)
        TITLE=$(echo ${ITEM} | jq .title)
        STR="${START_STR}『${TITLE}』／"

        if [ $((${#RE} + ${#TWEET} + ${#STR})) -ge 135 ]; then
            node ${TWIT_JS} "${RE}${TWEET:0:-1}"
            TWEET=""
        fi

        TWEET="${TWEET}${STR}"
    fi
done
if [ ${#TWEET} -gt 0 ]; then
    node ${TWIT_JS} "${RE}${TWEET:0:-1}"
fi
echo Finished process.
