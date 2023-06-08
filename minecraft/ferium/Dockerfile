# Maintainer https://github.com/Tetricz
FROM alpine:latest

ARG MC_VERSION=1.20.0
ARG FAB_LOADER_VERSION=0.14.21
ARG INSTALLER_VERSION=0.11.2
ARG VANILLA_OBJ_ID=15c777e2cfe0556eef19aab534b186c0c6f277e1
ARG ARCHITECTURE=
# For x86, leave blank, for arm64, use -arm64

RUN apk add --no-cache jq curl bash openjdk17 gcc unzip
RUN curl --connect-timeout 5 --retry 5 -proto '=https' -tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV MEMORY=2G \
    ENV_MC_VERSION=$MC_VERSION \
    EULA=false \
    FERIUM_CONFIG=ferium.json \
    MOD_LOADER=fabric

# Downloads the fabric server jar and the vanilla server jar and downloads the latest version of ferium
RUN mkdir -p /minecraft /jars
RUN curl -L --connect-timeout 5 --retry 5 --retry-delay 0 https://meta.fabricmc.net/v2/versions/loader/${MC_VERSION}/${FAB_LOADER_VERSION}/${INSTALLER_VERSION}/server/jar --output /jars/fabric-server-launch.jar
RUN curl -L --connect-timeout 5 --retry 5 --retry-delay 0 https://piston-data.mojang.com/v1/objects/${VANILLA_OBJ_ID}/server.jar --output /jars/server.jar
RUN curl -LO --connect-timeout 5 --retry 5 --retry-delay 0 $(curl -s https://api.github.com/repos/gorilla-devs/ferium/releases/latest | grep -i "browser_download_url.*\linux${ARCHITECTURE}-nogui" | sed 's/.*\(http.*\)"/\1/')
RUN unzip "ferium-linux*.zip" -d /usr/bin/
COPY ./entrypoint.sh /entrypoint.sh

# Change permissions of executables
RUN chmod +x /entrypoint.sh
RUN chmod +x /usr/bin/ferium

EXPOSE 25565/tcp 25565/udp 25575/tcp

WORKDIR /minecraft/

ENTRYPOINT [ "/entrypoint.sh" ]
