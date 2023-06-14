#!/bin/bash
getent group ${GID}
exit_result=$(echo $?)
if [ ${exit_result} == 0 ]; then
    echo "GID exists, adding existing group..."
    GROUP=$(getent group ${GID} | cut -d: -f1)
    adduser -g "Minecraft server user" -h "/minecraft" -s "/bin/bash" -D -u ${UID} --ingroup ${GROUP} minecraft
else
    echo "GID does not exist, creating group..."
    addgroup -g ${GID} minecraft
    adduser -g "Minecraft server user" -h "/minecraft" -s "/bin/bash" -D -u ${UID} --ingroup minecraft minecraft
    addgroup minecraft users
fi

echo -e "UID: $(id -u minecraft)"
echo -e "GID: $(id -g minecraft)"

su "minecraft" -c "exec \"$@\""
