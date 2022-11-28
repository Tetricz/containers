# Maintainer https://github.com/Tetricz
FROM alpine:latest

RUN apk add --no-cache openjdk17 curl

RUN mkdir /app && \
    cd /app && \
    curl --connect-timeout 5 --retry 5 --retry-delay 0 -LO https://github.com/Tetricz/ngavax/releases/download/v0.1-prerelease/ngavax.jar

COPY /config.json /app/config.json
COPY /www/ /app/www/

WORKDIR /app

CMD java -jar ngavax.jar config.json
