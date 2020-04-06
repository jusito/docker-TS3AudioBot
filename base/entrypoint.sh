#!/bin/sh

set -o errexit
set -o nounset

linkConfig() {
	file="$1"
	if [ ! -f "${MY_VOLUME}/$file" ] && [ -f "/home/TS3AudioBot/$file" ]; then
		mv -v "/home/TS3AudioBot/$file" "${MY_VOLUME}/$file"
	fi
	if [ -f "${MY_VOLUME}/$file" ]; then
		rm -v "/home/TS3AudioBot/$file"
		ln -vs "${MY_VOLUME}/$file" "/home/TS3AudioBot/$file"
	fi
}


if [ ! -d "${MY_VOLUME}/bots" ]; then
	mkdir "${MY_VOLUME}/bots"
	rm -rf "/home/TS3AudioBot/bots"
fi
ln -s "${MY_VOLUME}/bots" /home/TS3AudioBot/bots

linkConfig "rights.toml"
linkConfig "ts3audiobot.toml"
	
exec dotnet /home/TS3AudioBot/TS3AudioBot.dll