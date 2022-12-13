# Maintainer https://github.com/Tetricz
FROM alpine:latest

ARG MC_VERSION=1.19.3
ARG FAB_LOADER_VERSION=0.14.11
ARG INSTALLER_VERSION=0.11.1
ARG VANILLA_OBJ_ID=c9df48efed58511cdd0213c56b9013a7b5c9ac1f

RUN apk add --no-cache jq curl bash openjdk17

ENV MEMORY=2G

COPY . /

RUN chmod +x /entrypoint.sh
RUN curl -L --connect-timeout 5 --retry 5 --retry-delay 0 https://meta.fabricmc.net/v2/versions/loader/${MC_VERSION}/${FAB_LOADER_VERSION}/${INSTALLER_VERSION}/server/jar --output /fabric-server-launch.jar
RUN curl -L --connect-timeout 5 --retry 5 --retry-delay 0 https://piston-data.mojang.com/v1/objects/${VANILLA_OBJ_ID}/server.jar --output /server.jar

EXPOSE 25565/tcp 25565/udp 25575/tcp

ENTRYPOINT [ "/entrypoint.sh" ]
