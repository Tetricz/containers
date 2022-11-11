# Maintainer https://github.com/Tetricz
# https://hub.docker.com/_/python?tab=description

FROM alpine:latest as downloader
# https://github.com/yt-dlp/yt-dlp
ARG GIT_BRANCH=master
RUN apk add --no-cache curl git \
 && cd / && git clone --branch ${GIT_BRANCH} https://github.com/yt-dlp/yt-dlp.git

FROM python:3-alpine

COPY ./entrypoint.bash ./
COPY ./data/* ./
COPY --from=downloader /yt-dlp/yt_dlp /yt_dlp

ENV UID="1000" \
 GID="1000" \
 TIME_INTERVAL="600" \
 COOKIES="false" \
 QUIET="TRUE" \
 FORMAT="bestvideo+bestaudio/best" \
 NAMING_CONVENTION="%(format_id)s-%(title)s.%(ext)s" \
 PROXY= \
 DATE= \
 ARCHIVE_DOWNLOADED="TRUE"

RUN apk add --no-cache bash dos2unix ffmpeg procps \
 && mkdir -p /config/ \
 && mkdir -p /data/ \
 && chmod a+rx ./entrypoint.bash

ENTRYPOINT ["./entrypoint.bash"]