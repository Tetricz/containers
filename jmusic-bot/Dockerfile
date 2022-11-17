# Maintainer https://github.com/Tetricz
ARG OPENJDK_VERSION=17-alpine
# https://hub.docker.com/_/openjdk
FROM openjdk:${OPENJDK_VERSION}

RUN if [ $(uname -m) = "x86_64" ]; then apk add --no-cache gettext curl; else apt-get update && apt-get install gettext curl -y && apt-get clean; fi

ENV COMMAND_PREFIX='@mention' \
    ALT_COMMAND_PREFIX='' \
    BOT_OWNER='' \
    BOT_TOKEN='' \
    BOT_STATUS='ONLINE' \
    SONGINSTATUS='false' \
    PLAYLISTSFOLDER='Playlists' \
    LYRICS_DEFUALT='A-Z Lyrics'

WORKDIR /jmusic-bot

COPY ./config.txt.sample /config.txt.sample
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
