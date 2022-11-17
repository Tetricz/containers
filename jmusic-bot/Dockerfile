# Maintainer https://github.com/Tetricz
FROM ubuntu:jammy

RUN apt-get update && apt-get upgrade -y && apt-get install gettext curl openjdk-17-jre-headless -y && apt-get clean

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
