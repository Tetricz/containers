# Maintainer https://github.com/Tetricz
FROM alpine:latest

RUN apk add --no-cache openjdk17-jre-headless

ENV MEMORY=2G \
    JARFILE=server.jar

COPY --chmod=755 entrypoint.sh /entrypoint.sh

WORKDIR /minecraft

ENTRYPOINT [ "/entrypoint.sh" ]
CMD java -Xmx${MEMORY} -Xms${MEMORY} -jar ${JARFILE}
