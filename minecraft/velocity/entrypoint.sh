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

su "velocity" -c "exec \"$@\""

