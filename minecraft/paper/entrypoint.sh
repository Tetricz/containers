#!/bin/bash
getent group ${GID}
exit_result=$(echo $?)
if [ ${exit_result} == 0 ]; then
    echo "GID exists, adding existing group..."
    GROUP=$(getent group ${GID} | cut -d: -f1)
    adduser -g "Paper server user" -h "/config" -s "/bin/bash" -D -u ${UID} --ingroup ${GROUP} paper
else
    echo "GID does not exist, creating group..."
    addgroup -g ${GID} paper
    adduser -g "Paper server user" -h "/config" -s "/bin/bash" -D -u ${UID} --ingroup paper paper
    addgroup paper users
fi

echo -e "UID: $(id -u paper)"
echo -e "GID: $(id -g paper)"

chown ${UID}:${GID} /paper.jar
chown -R ${UID}:${GID} /minecraft

echo -e "Starting server..."

su "paper" -c "exec /usr/bin/java -Xms8G -Xmx8G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar /paper.jar & echo \$! > /tmp/server.pid"

trap_handler () {
    echo -e "Stopping server..."
    kill -SIGTERM $(cat /tmp/server.pid)
    echo -e "Server stopped."
    exit 0
}

trap trap_handler SIGINT SIGTERM
while [ -e /proc/$(cat /tmp/server.pid) ]; do
    sleep 0.5
done
