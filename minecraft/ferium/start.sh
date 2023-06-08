#!/bin/bash
echo "Starting server..."
java -Xmx${MEMORY} -Xms${MEMORY} -jar fabric-server-launch.jar nogui &
killpid=$!
echo "Server started with PID: $killpid"
while true
do
    wait $killpid
    echo "Server stopped, shutting down..."
    exit 0;
done
