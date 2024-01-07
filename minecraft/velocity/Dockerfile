# Maintainer https://github.com/Tetricz
# Build Velocity from github source
FROM gradle:latest as builder

RUN apt-get update
RUN apt-get install -y git
RUN git clone https://github.com/PaperMC/Velocity.git /velocity
RUN cd /velocity && ./gradlew build

FROM alpine:latest

ARG UID=1000
ARG GID=1000

RUN apk add --no-cache openjdk17-jre-headless bash curl libstdc++ libc6-compat eudev-dev

COPY --chmod=755 --from=builder /velocity/proxy/build/libs/velocity*all.jar /velocity.jar
COPY --chmod=755 entrypoint.sh /entrypoint.sh

ENV MEMORY=1G \
    UID=${UID} \
    GID=${GID}

WORKDIR /minecraft/

ENTRYPOINT [ "/entrypoint.sh" ]
