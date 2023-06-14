# Maintainer https://github.com/Tetricz
FROM alpine:latest

RUN apk add --no-cache openjdk17-jre-headless

ENV MEMORY=2G \
    JARFILE=server.jar

WORKDIR /minecraft

EXPOSE 25565/tcp 25575/tcp

CMD java -Xmx${MEMORY} -Xms${MEMORY} -jar ${JARFILE}
