#!/bin/bash
export STEAMCMD_DIR="/home/steam/steamcmd/"
export APPDATA_DIR="/home/steam/Zomboid/"
export INST_DIR="/home/steam/gamedata/"

usermod -u ${UID} "steam"
usermod -g ${GID} "steam"

id -u "steam"
id -g "steam"

mkdir -p "${APPDATA_DIR}" "${INST_DIR}"
chown -R steam:steam "${APPDATA_DIR}"
chown -R steam:steam "${INST_DIR}"

## Check for app_update script
if [ ! -f "${APPDATA_DIR}app_update" ]; then
    echo "No app_update scripts found, copying default..."
    cp "${STEAMCMD_DIR}app_update" "${APPDATA_DIR}app_update"
fi

su "steam" -c "${STEAMCMD_DIR}steamcmd.sh +runscript ${APPDATA_DIR}app_update"

su "steam" -c "exec \"$@\""
