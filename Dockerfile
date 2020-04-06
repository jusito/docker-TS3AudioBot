FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine AS bot_build

ARG BOT_VERSION="develop"
ARG DOTNET_VERSION="3.1"

RUN apk update && \
	apk add git && \
	git clone -q --branch "$BOT_VERSION" --recurse-submodules https://github.com/Splamy/TS3AudioBot.git && \
	dotnet build -v "n" --framework "netcoreapp${DOTNET_VERSION}" --configuration "Release" "TS3AudioBot"



FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine

COPY --from=bot_build /TS3AudioBot/TS3AudioBot/bin/Release/netcoreapp* "/home/TS3AudioBot"

RUN apk update && \
	apk add opus-dev ffmpeg python3 && \
	pip3 install youtube-dl
	
ENTRYPOINT ["dotnet", "/home/TS3AudioBot/TS3AudioBot.dll"]