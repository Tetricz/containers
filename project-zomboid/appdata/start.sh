#!/bin/bash

echo "---Starting...---"
term_handler() {
	kill -SIGINT $(pidof ProjectZomboid64)
	tail --pid=$(pidof ProjectZomboid64) -f 2>/dev/null
	sleep 0.5
	exit 143;
}

trap 'kill ${!}; term_handler' SIGTERM

"/bin/start-server.sh" &
killpid="$!"
while true
do
	wait $killpid
	exit 0;
done
