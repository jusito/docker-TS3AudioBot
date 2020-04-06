FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine AS build

ARG BOT_VERSION="develop"
ARG DOTNET_VERSION="3.1"

RUN apk update && \
	apk add git && \
	git clone -q --branch "$BOT_VERSION" --recurse-submodules https://github.com/Splamy/TS3AudioBot.git && \
	dotnet build -v "n" --framework "netcoreapp${DOTNET_VERSION}" --configuration "Release" "TS3AudioBot"



FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine

COPY --from=build /TS3AudioBot/TS3AudioBot/bin/Release/netcoreapp* "/home/TS3AudioBot"
COPY /base/entrypoint.sh /home/entrypoint.sh

ENV MY_GROUP_ID=10000 \
	MY_USER_ID=10000 \
	MY_NAME=docker \
	MY_VOLUME=/home/configuration

RUN apk update && \
	apk add opus-dev ffmpeg python3 && \
	pip3 install youtube-dl && \
	mkdir /home/configuration && \
	\
# create user
	addgroup -g "$MY_GROUP_ID" "$MY_NAME" && \
	adduser -h "$MY_VOLUME" -g "" -s "/bin/false" -G "$MY_NAME" -D -u "$MY_USER_ID" "$MY_NAME" && \
# add permissions to all in /home
	chown -R "$MY_NAME:$MY_NAME" "/home" && \
	chmod -R u=rwx,go= "/home" && \
# remove temp files
	apk del --quiet --no-cache --progress --purge && \
	rm -rf /var/cache/apk/*
	
ENTRYPOINT ["/home/entrypoint.sh"]

USER "$MY_USER_ID:$MY_GROUP_ID"