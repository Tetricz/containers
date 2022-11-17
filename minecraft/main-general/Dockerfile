# Maintainer https://github.com/Tetricz
FROM ubuntu:jammy
RUN apt-get update && apt-get upgrade -y && apt-get install openjdk-17-jre-headless -y && apt-get clean

ENV MEMORY=2G \
    JARFILE=server.jar

WORKDIR /minecraft

EXPOSE 25565/tcp 25575/tcp

CMD java -Xmx${MEMORY} -Xms${MEMORY} -jar ${JARFILE}
