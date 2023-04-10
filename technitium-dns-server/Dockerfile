# Maintainer https://github.com/Tetricz
# https://hub.docker.com/_/microsoft-dotnet-sdk
# https://hub.docker.com/_/microsoft-dotnet-runtime/
ARG SDK_VERSION=7.0-alpine
ARG RUNTIME_VERSION=7.0-alpine

FROM alpine:latest as downloader
# https://github.com/TechnitiumSoftware/DnsServer
ARG TECHDNS_VERSION=master
RUN apk add --no-cache curl unzip \
 && curl -L --connect-timeout 5 --retry 5 --retry-delay 0 https://github.com/TechnitiumSoftware/TechnitiumLibrary/archive/refs/heads/master.zip -o techlibrary.zip \
 && unzip *library.zip \
 && curl -L --connect-timeout 5 --retry 5 --retry-delay 0 https://github.com/TechnitiumSoftware/DnsServer/archive/refs/heads/${TECHDNS_VERSION}.zip -o techdns.zip \
 && unzip *dns.zip

FROM mcr.microsoft.com/dotnet/sdk:${SDK_VERSION} as builder
# https://docs.microsoft.com/en-us/dotnet/core/rid-catalog#linux-rids
COPY --from=downloader /TechnitiumLibrary-master /TechnitiumLibrary-master
COPY --from=downloader DnsServer-* DnsServer-build
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
RUN dotnet build /TechnitiumLibrary/TechnitiumLibrary.ByteTree/TechnitiumLibrary.ByteTree.csproj -c Release --output="/TechnitiumLibrary/bin" --use-current-runtime
RUN dotnet build /TechnitiumLibrary/TechnitiumLibrary.Net/TechnitiumLibrary.Net.csproj -c Release --output="/TechnitiumLibrary/bin" --use-current-runtime
RUN dotnet publish /DnsServer/DnsServerApp/DnsServerApp.csproj -c Release --output="/dns" --use-current-runtime

FROM mcr.microsoft.com/dotnet/aspnet:${RUNTIME_VERSION}

COPY --from=builder /dns /dns
WORKDIR /dns
EXPOSE 53/udp 53/tcp 5380/tcp 67/udp

ENTRYPOINT [ "dotnet", "DnsServerApp.dll" ]
