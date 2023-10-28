FROM cm2network/steamcmd:root

ENV ADMIN_PWD="soopasafe" \
    GAME_PARAMS="" \
    UID=1000 \
    GID=1000

RUN apt-get update \
    && apt-get install screen watchdog -y \
    && apt-get remove --purge --auto-remove -y \
	&& rm -rf /var/lib/apt/lists/*

COPY  --chown=steam:steam --chmod=755 ./appdata/entrypoint.sh       /bin/entrypoint.sh
COPY  --chown=steam:steam --chmod=666 ./appdata/app_update          /home/steam/steamcmd/app_update

WORKDIR "/"

EXPOSE 16261/tcp 16261/udp 16262/tcp 16262/udp

ENTRYPOINT [ "/bin/entrypoint.sh" ]
