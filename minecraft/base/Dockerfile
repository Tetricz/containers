# Maintainer https://github.com/Tetricz
FROM alpine:latest

RUN apk add --no-cache openjdk17-jre-headless bash libstdc++

ENV MEMORY=2G \
    JARFILE=server.jar \
    GID=1000 \
    UID=1000

COPY --chmod=777 ./entrypoint.sh /entrypoint.sh

WORKDIR /minecraft/

ENTRYPOINT [ "/entrypoint.sh" ]
