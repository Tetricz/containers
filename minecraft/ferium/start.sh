#!/bin/bash
echo -e "Starting server..."
/usr/bin/java -Xmx${MEMORY} -Xms${MEMORY} -jar fabric-server-launch.jar
