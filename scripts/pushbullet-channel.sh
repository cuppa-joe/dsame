#!/bin/sh
echo OUTPUT: Pushbullet Channel 1>&2
PB_TOKEN='your_access_token'
PB_CHANNEL_TAG='your_channel_tag'
PB_API='https://api.pushbullet.com/v2/pushes'
TITLE='Weather Alert'
TYPE=$1
MSG=$2
curl --header "Authorization: Bearer $PB_TOKEN" -X POST $PB_API --header "Content-Type: application/json" --data-binary "{\"channel_tag\": \"$PB_CHANNEL_TAG\", \"type\": \"note\", \"title\": \"$TITLE: ${TYPE:="Test"}\", \"body\": \"${MSG:="Test Message"}\"}"
