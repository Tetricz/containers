#!/bin/bash
ferium -V
RED='\033[1;31m'
NC='\033[0m' # No Color
# print profile, if empty the process will exit with code 1
ferium --config-file "/minecraft/${FERIUM_CONFIG}" profile list
if [ $? -eq 0 ]; then
    echo "Profile exists, skipping"
    echo -e "To add mods to run on the host of the container, '${RED}docker exec -it <container> /bin/bash${NC}' and then '${RED}ferium --config-file ${FERIUM_CONFIG} add <mod/slug>${NC}'"
else
    echo -e "${RED}Profile does not exist, creating${NC}"
    ferium --config-file "/minecraft/${FERIUM_CONFIG}" profile create --name "Default" --game-version "${ENV_MC_VERSION}" --mod-loader "${MOD_LOADER}" --output-dir "/minecraft/mods/"
    echo -e "To add mods to run on the host of the container, '${RED}docker exec -it <container> /bin/bash${NC}' and then '${RED}ferium --config-file ${FERIUM_CONFIG} add <mod/slug>${NC}'"
fi
# ensure the profile is correct
ferium --config-file "/minecraft/${FERIUM_CONFIG}" profile configure --name "Default" --game-version "${ENV_MC_VERSION}" --mod-loader "${MOD_LOADER}" --output-dir "/minecraft/mods/"
# update mods with ferium
ferium --config-file "/minecraft/${FERIUM_CONFIG}" upgrade >> /minecraft/ferium.log
