# Maintainer https://github.com/Tetricz
ARG OPENJDK_VERSION=17-alpine
# https://hub.docker.com/_/openjdk
FROM openjdk:${OPENJDK_VERSION}
RUN apk add --no-cache jq curl bash
ENV MEMORY=2G

COPY . /

RUN chmod +x /entrypoint.sh
RUN curl -L https://meta.fabricmc.net/v2/versions/loader/1.19.2/0.14.9/0.11.1/server/jar --output /fabric-server-launch.jar
RUN curl -L https://piston-data.mojang.com/v1/objects/f69c284232d7c7580bd89a5a4931c3581eae1378/server.jar --output /server.jar

EXPOSE 25565/tcp 25565/udp 25575/tcp

ENTRYPOINT [ "/entrypoint.sh" ]