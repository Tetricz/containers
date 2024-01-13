#!/bin/bash

export STEAMCMD_DIR="/home/steam/steamcmd/"
export APPDATA_DIR="/home/steam/Zomboid/"
export INST_DIR="/home/steam/gamedata/"

## Check for app_update script
if [ ! -f "${APPDATA_DIR}app_update" ]; then
    echo "No app_update scripts found, copying default..."
    cp "${STEAMCMD_DIR}app_update" "${APPDATA_DIR}app_update"
fi

"${STEAMCMD_DIR}steamcmd.sh" +runscript "${APPDATA_DIR}app_update"

cd "${INST_DIR}"

if "${INST_DIR}/jre64/bin/java" -version > /dev/null 2>&1; then
	echo "64-bit java detected"
	export PATH="${INST_DIR}/jre64/bin:$PATH"
	export LD_LIBRARY_PATH="${INST_DIR}/linux64:${INST_DIR}/natives:${INST_DIR}:${INST_DIR}/jre64/lib/:${LD_LIBRARY_PATH}"
	LIBPZXINIT="libPZXInitThreads64.so"
	JSIG="libjsig.so"
	LD_PRELOAD="${LD_PRELOAD}:${JSIG}:${LIBPZXINIT}" "${INST_DIR}ProjectZomboid64" -adminpassword "${ADMIN_PWD}" "${GAME_PARAMS}"
elif "${INST_DIR}/jre/bin/java" -client -version > /dev/null 2>&1; then
	echo "32-bit java detected"
	export PATH="${INST_DIR}/jre/bin:$PATH"
	export LD_LIBRARY_PATH="${INST_DIR}/linux32:${INST_DIR}/natives:${INST_DIR}:${INST_DIR}/jre/lib/:${LD_LIBRARY_PATH}"
	LIBPZXINIT="libPZXInitThreads64.so"
	JSIG="libjsig.so"
	LD_PRELOAD="${LD_PRELOAD}:${JSIG}:${LIBPZXINIT}" "${INST_DIR}ProjectZomboid32" -adminpassword "${ADMIN_PWD}" "${GAME_PARAMS}"
else
	echo "couldn't determine 32/64 bit of java"
fi
