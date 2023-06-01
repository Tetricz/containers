#!/bin/bash
#
###############################################################################
#
# Edit memory option -Xmx in ProjectZomboid64.json for 64bit servers (common)
#   or ProjectZomboid32.json for 32bit servers (rare)
#
###############################################################################

cd "${INST_DIR}"

if "${INST_DIR}/jre64/bin/java" -version > /dev/null 2>&1; then
        echo "64-bit java detected"
        export PATH="${INST_DIR}/jre64/bin:$PATH"
        export LD_LIBRARY_PATH="${INST_DIR}/linux64:${INST_DIR}/natives:${INST_DIR}:${INST_DIR}/jre64/lib/amd64:${LD_LIBRARY_PATH}"
        export LD_PRELOAD="${LD_PRELOAD}"
        screen -S PZ -L -Logfile ${INST_DIR}/masterLog.0 -d -m ${INST_DIR}/ProjectZomboid64 -adminpassword ${ADMIN_PWD} ${GAME_PARAMS}
        sleep 5
        screen -S watchdog -d -m ${INST_DIR}/start-watchdog.sh
        tail -f ${INST_DIR}/masterLog.0
elif "${INST_DIR}/jre/bin/java" -client -version > /dev/null 2>&1; then
        echo "32-bit java detected"
        export PATH="${INST_DIR}/jre/bin:$PATH"
        export LD_LIBRARY_PATH="${INST_DIR}/linux32:${INST_DIR}/natives:${INST_DIR}:${INST_DIR}/jre/lib/i386:${LD_LIBRARY_PATH}"
        export LD_PRELOAD="${LD_PRELOAD}"
        screen -S PZ -L -Logfile ${INST_DIR}/masterLog.0 -d -m ${INST_DIR}/ProjectZomboid32 -adminpassword ${ADMIN_PWD} ${GAME_PARAMS}
        sleep 2
        screen -S watchdog -d -m ${INST_DIR}/start-watchdog.sh
        tail -f ${INST_DIR}/masterLog.0
else
        echo "couldn't determine 32/64 bit of java"
fi
#exit 0
#
# EOF
#
###############################################################################
