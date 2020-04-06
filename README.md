# docker-TS3AudioBot

docker run -d --rm --name develop develop --non-interactive
 
# youtube-dl


!alias add ytp "!x (!search from youtube (!param 0)) (!search play 0)"
docker run -it --rm --name develop python:3-alpine pip install youtube-dl; /bin/sh