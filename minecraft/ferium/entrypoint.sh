#!/bin/bash
addgroup -g ${GID} minecraft
adduser -g "Minecraft server user" -h "/minecraft" -s "/bin/bash" -D -u ${UID} --ingroup users minecraft

id -u "minecraft"
id -g "minecraft"

# Create eula.txt if one does not exist
if [ ! -e /minecraft/eula.txt ]; then
    echo -e "Generated by $(uname -a)\neula=${EULA}" > /minecraft/eula.txt
fi

mkdir -p /minecraft/logs
mkdir -p /minecraft/mods
mkdir -p /minecraft/config
mkdir -p /minecraft/scripts

# Rather than download the server jar, it's baked into the image
# This statement is to avoid having the persistent volume having outdated jars.
# On the first run, copy the jar to the persistent volume
RED='\033[1;31m'
NC='\033[0m' # No Color
EXAMPLE="
#!/bin/bash
echo -e \"This is a custom script.\"
echo -e \"It can be found in the minecraft/scripts/ directory.\"
echo -e \"Add any bash script ending with a ${RED}.sh${NC} to be executed before server launch.\"
echo -e \"These scripts will be executed on container start\"
echo -e \"This script is an example, and can be removed.\"
"

if [ ! -e /jars/copied ]; then
    cp /jars/*.jar /minecraft/
    cp /minecraft/ferium.log /minecraft/logs/ferium.log.$(date +%s)
    rm -f /minecraft/ferium.log
    touch /minecraft/scripts/example.sh
    echo "$EXAMPLE" > /minecraft/scripts/example.sh
    touch /jars/copied
fi

chown -R minecraft:minecraft /minecraft

su "minecraft" -c "exec /auto-script.sh"
su "minecraft" -c "exec /update.sh"
#su "minecraft" -c "exec \"$@\""
