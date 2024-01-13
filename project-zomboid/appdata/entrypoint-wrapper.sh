#!/bin/bash

usermod -u ${UID} "steam"
usermod -g ${GID} "steam"

echo -e "UID: $(id -u steam)"
echo -e "GID: $(id -g steam)"

chown -R ${UID}:${GID} /home/steam

su "steam" -c "/bin/entrypoint.sh & echo \$! > /tmp/server.pid"

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
