# Maintainer https://github.com/Tetricz
# Build Velocity from github source
FROM gradle:latest as builder

RUN apt-get update
RUN apt-get install -y git
RUN git clone https://github.com/PaperMC/Paper.git /paper
RUN git config --global user.email "anonymous"
RUN git config --global user.name "anonymous"
RUN cd /paper && ./gradlew applyPatches && ./gradlew createReobfBundlerJar

FROM tetricz/autoplug:amd64

ARG UID=1000
ARG GID=1000

RUN apk add --no-cache openjdk17-jre-headless bash curl libstdc++ libc6-compat eudev-dev

COPY --chmod=755 --from=builder /paper/build/libs/paper*.jar /paper.jar
COPY --chmod=755 entrypoint.sh /entrypoint.sh

ENV UID=${UID} \
    GID=${GID}

WORKDIR /minecraft/

ENTRYPOINT [ "/entrypoint.sh" ]
