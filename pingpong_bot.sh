#!/bin/bash
# Server status telegram bot shell
#
# Check your server status and send a message with telegram
# by David Stegmüller
# Feat Suwon Chae

# #######################################################################
# Configurations

#API_TOKEN="123456789:AbCdEfgijk1LmPQRSTu234v5Wx-yZA67BCD"
API_TOKEN=""

# USER_CHAT_ID=123456789
USER_CHAT_ID=""

EXPECTED_STATUS_CODE=0
POLLING_TIME=60 #(sec)
messageOnDown="is unavailable!"
messageOnRevive="comeback!"

# TARGET_SERVER_IP="127.0.0.1"
TARGET_SERVER_IP[0]="10.10.50.101"
TARGET_SERVER_IP[1]="10.10.50.102"
TARGET_SERVER_IP[2]="10.10.50.103"
TARGET_SERVER_IP[3]="10.10.50.104"
TARGET_SERVER_IP[4]="10.10.50.105"
TARGET_SERVER_IP[5]="10.10.50.106"
TARGET_SERVER_IP[6]="10.10.50.107"

# TARGET_SERVER_NAME="MyServer"
TARGET_SERVER_NAME[0]="TrueNAS"
TARGET_SERVER_NAME[1]="Nextcloud"
TARGET_SERVER_NAME[2]="GitLab"
TARGET_SERVER_NAME[3]="Jellyfin"
TARGET_SERVER_NAME[4]="Tdarr"
TARGET_SERVER_NAME[5]="JDownloader"
TARGET_SERVER_NAME[6]="Hass.io"

#######################################################################
# Telegram

sendMessageToTelegram() {
  curl -s \
    -X POST \
    https://api.telegram.org/bot$API_TOKEN/sendMessage \
    -d text="$1" \
    -d chat_id=$USER_CHAT_ID > /dev/null
}

#######################################################################
# Init

isDown[0]=false
isDown[1]=false
isDown[2]=false
isDown[3]=false
isDown[4]=false
isDown[5]=false
isDown[6]=false

#######################################################################
# Programm

echo ""
echo "Monitoring started... $(date +%Y-%m-%d" "%H:%M:%S)"
echo ""

sendMessageToTelegram "Monitoring started..."

while true
do
    for (( i=0; i<"${#TARGET_SERVER_IP[@]}"; i++ ))
    do
      NOW=$(date +%Y-%m-%d" "%H:%M:%S)
      ping -q -c1 "${TARGET_SERVER_IP[$i]}" > /dev/null
      response=$?
      if (($response))
      then
        if [ ${isDown[$i]} == false ] 
        then
          echo "${TARGET_SERVER_NAME[$i]} $messageOnDown - $NOW" 
          isDown[$i]=true
          sendMessageToTelegram "${TARGET_SERVER_NAME[$i]} $messageOnDown"
        fi
      else
        if [ ${isDown[$i]} == true ] 
        then
          echo "${TARGET_SERVER_NAME[$i]} $messageOnRevive - $NOW" 
          isDown[$i]=false
          sendMessageToTelegram "${TARGET_SERVER_NAME[$i]} $messageOnRevive"
        fi
      fi
    done
    sleep $POLLING_TIME
done;

#######################################################################
# referred pages
#
# https://core.telegram.org/bots#3-how-do-i-create-a-bot
# https://core.telegram.org/bots/api
# https://community.onion.io/topic/499/sending-telegram-messages-via-bots
# https://github.com/doortts/is-alive-bot.sh/blob/master/is-alive-bot.sh
