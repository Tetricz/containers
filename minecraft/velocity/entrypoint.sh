#!/bin/bash
getent group ${GID}
exit_result=$(echo $?)
if [ ${exit_result} == 0 ]; then
    echo "GID exists, adding existing group..."
    GROUP=$(getent group ${GID} | cut -d: -f1)
    adduser -g "Velocity server user" -h "/config" -s "/bin/bash" -D -u ${UID} --ingroup ${GROUP} velocity
else
    echo "GID does not exist, creating group..."
    addgroup -g ${GID} velocity
    adduser -g "Velocity server user" -h "/config" -s "/bin/bash" -D -u ${UID} --ingroup velocity velocity
    addgroup velocity users
fi

echo -e "UID: $(id -u velocity)"
echo -e "GID: $(id -g velocity)"

curl -LO --connect-timeout 5 --retry 5 --retry-delay 0 https://github.com/Osiris-Team/AutoPlug-Releases/raw/master/beta-builds/AutoPlug-Client.jar
chown ${UID}:${GID} AutoPlug-Client.jar
chown ${UID}:${GID} /velocity.jar
chown -R ${UID}:${GID} /minecraft

echo -e "Starting proxy server..."

# su "velocity" -c "exec /usr/bin/java -Xms${MEMORY} -Xmx${MEMORY} -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15 -jar /velocity.jar & echo \$! > /tmp/server.pid"
su "velocity" -c "exec /usr/bin/java -Dfile.encoding=UTF-8 -jar AutoPlug-Client.jar & echo \$! > /tmp/server.pid"

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
