#!/bin/bash
getent group ${GID}
exit_result=$(echo $?)
if [ ${exit_result} == 0 ]; then
    echo "GID exists, adding existing group..."
    GROUP=$(getent group ${GID} | cut -d: -f1)
    echo "GROUP: ${GROUP}"
    adduser -g "Minecraft server user" -h "/minecraft" -s "/bin/bash" -D -u ${UID} --ingroup ${GROUP} minecraft
else
    echo "GID does not exist, creating group..."
    addgroup -g ${GID} minecraft
    adduser -g "Minecraft server user" -h "/minecraft" -s "/bin/bash" -D -u ${UID} --ingroup minecraft minecraft
    addgroup minecraft users
fi

echo -e "UID: $(id -u minecraft)"
echo -e "GID: $(id -g minecraft)"

echo -e "Starting server..."
su "minecraft" -c "/usr/bin/java -Xmx${MEMORY} -Xms${MEMORY} -jar ${JARFILE} & echo \$! > /tmp/server.pid"

trap_handler () {
    echo -e "Stopping server..."
    kill -SIGTERM $(cat /tmp/server.pid)
    echo -e "Server stopped."
    exit 0
}

trap trap_handler() SIGINT SIGTERM
while [ -e /proc/$(cat /tmp/server.pid) ]; do
    sleep 0.5
done
