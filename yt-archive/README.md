# yt-dl channels

[![Docker Image CI](https://github.com/Tetricz/docker-yt-archive/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Tetricz/docker-yt-archive/actions/workflows/docker-image.yml)

## Quick Start

If you happen to enable cookies, make sure there is a cookies.txt file in your appdata location.
volume mapping

```text
/your/directory:/config/   (channels.txt and .downloaded archive)
/your/directory:/data/     (the folders for the youtube channels)
```

### Docker Compose

```docker-compose
version: '3'
services:
    yt-dl:
        restart: unless-stopped
        container_name: yt-archive
        image: tetricz/yt-archive
        volumes:
         - </your/directory>:/config
         - </your/directory>:/data
        environment:
         - COOKIES="FALSE"
         - TIME_INTERVAL="600"
         - QUIET="TRUE"
         - UID="1000"
         - GID="1000"
        tmpfs:
         - /tmp:rw,noexec,nosuid,size=1g
```

### Docker Run

```bash
docker run -dit --tmpfs /tmp:rw,noexec,nosuid,size=1g -v </your/directory>:/data -v </your/directory>:/config --name yt-archive tetricz/yt-archive
```
