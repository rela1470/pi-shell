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
RESERVES_ENDPOINT="/reserves.json"
RECORDING_ENDPOINT="/recording.json"

# BASIC認証を行うか
IS_BASIC=0
USER="user"
PASSWORD="password"

# リプライ先（空欄でも可能）
RE=""

# twit.jsのパス
TWIT_JS="/home/pi/chinachu/twit.js"

# 以下処理
echo Start process.
URL1="http://${FQDN_OR_IP}:${PORT}${API_BASE}${RECORDING_ENDPOINT}"
URL2="http://${FQDN_OR_IP}:${PORT}${API_BASE}${RESERVES_ENDPOINT}"
if [ ${IS_BASIC} -eq 1 ]; then
    URL1="http://${USER}:${PASSWORD}@${FQDN_OR_IP}:${PORT}${API_BASE}${RECORDING_ENDPOINT}"
    URL2="http://${USER}:${PASSWORD}@${FQDN_OR_IP}:${PORT}${API_BASE}${RESERVES_ENDPOINT}"
fi

# 録画中か確認
RECORDINGS=$(curl -s ${URL1})
RECORDINGS_LENGTH=$(echo ${RECORDINGS} | jq length)
if [ ${RECORDINGS_LENGTH} -gt 0 ]; then
    node ${TWIT_JS} "${RE}現在録画中のため、再起動処理はキャンセルされました。"
    echo Chinachu is now recording... Reboot is canceled.
    exit -1
fi

# 10分以内に録画予約がないか確認
TIME=$(date +%s)
RESERVES=$(curl -s ${URL2})
RESERVES_LENGTH=$(echo ${RESERVES} | jq length)

for i in $(seq 0 $((${RESERVES_LENGTH} - 1))); do
    ITEM=$(echo ${RESERVES} | jq .[$i])
    START=$(echo ${ITEM} | jq .start)
    DELTA_SEC=$(($((${START} / 1000)) - $(date +%s)))
    DELTA=$((${DELTA_SEC} / 60))

    if [ ${DELTA} -lt 10 ]; then
        node ${TWIT_JS} "${RE}10分以内に録画予約があるため、再起動処理はキャンセルされました。"
        echo Chinachu was reserving a program.... Reboot is canceled.
        exit -1
    fi
done
echo Now reboot.

reboot
