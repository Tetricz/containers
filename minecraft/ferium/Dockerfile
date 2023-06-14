# Maintainer https://github.com/Tetricz
FROM alpine:latest

ARG MC_VERSION=1.20.1
ARG FAB_LOADER_VERSION=0.14.21
ARG INSTALLER_VERSION=0.11.2
ARG VANILLA_OBJ_ID=84194a2f286ef7c14ed7ce0090dba59902951553
ARG ARCHITECTURE=
# For x86, leave blank, for arm64, use -arm64

ARG UID=1000
ARG GID=1000

RUN apk add --no-cache curl bash openjdk17-jre-headless unzip
RUN curl --connect-timeout 5 --retry 5 -proto '=https' -tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile=minimal

ENV MEMORY=2G \
    ENV_MC_VERSION=$MC_VERSION \
    EULA=false \
    FERIUM_CONFIG=ferium.json \
    MOD_LOADER=fabric \
    UID=${UID} \
    GID=${GID}

# Downloads the fabric server jar and the vanilla server jar and downloads the latest version of ferium
RUN mkdir -p /jars
RUN curl -L --connect-timeout 5 --retry 5 --retry-delay 0 https://meta.fabricmc.net/v2/versions/loader/${MC_VERSION}/${FAB_LOADER_VERSION}/${INSTALLER_VERSION}/server/jar --output /jars/fabric-server-launch.jar
RUN curl -L --connect-timeout 5 --retry 5 --retry-delay 0 https://piston-data.mojang.com/v1/objects/${VANILLA_OBJ_ID}/server.jar --output /jars/server.jar
RUN curl -LO --connect-timeout 5 --retry 5 --retry-delay 0 $(curl -s https://api.github.com/repos/gorilla-devs/ferium/releases/latest | grep -i "browser_download_url.*\linux${ARCHITECTURE}-nogui" | sed 's/.*\(http.*\)"/\1/')
RUN unzip "ferium-linux*.zip" -d /usr/bin/
RUN rm ferium*.zip

COPY --chmod=777 ./entrypoint.sh /entrypoint.sh
COPY --chmod=777 ./start.sh /start.sh
COPY --chmod=777 ./update.sh /update.sh
COPY --chmod=777 ./auto-script.sh /auto-script.sh

# Change permissions of executables
RUN chmod +x /usr/bin/ferium

EXPOSE 25565/tcp 25565/udp 25575/tcp

WORKDIR /minecraft/

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/start.sh" ]
