#!/bin/bash
#iptables setup
/home/ip-tables.sh

#setup /dev/net/tun
/home/tun.sh

#set variables
export ovpnDIR="/openvpn"
export ovpnFILE="${ovpnDIR}/$(ls ${ovpnDIR} | shuf -n 1)"

#remove credentials
rm -f ${ovpnDIR}/cred.conf

echo "################################################"

#set variables and edit config file
if [[ -f "${ovpnFILE}" ]];
    then
        cat ${ovpnFILE} | while read line 
        do
            if [[ "${line}" == *"remote "*"${PORT}" ]];
            then
                echo ${line} > /tmp/ip
                export temp=$(echo ${line})
                sed -i '/remote-random/d' ${ovpnFILE}
                sed -i '/remote /d' ${ovpnFILE}
                sed -i "1 i\\${temp}" ${ovpnFILE}
                export REMOTE_IP="$(sed -n -e 's/remote //p' /tmp/ip | sed -n -e "s/ ${PORT}//p")"
                echo ${REMOTE_IP}
            fi
            if [[ "${line}" == "auth-user-pass" ]];
            then
                sed -i "/auth-user-pass/c\auth-user-pass ${ovpnDIR}/cred.conf" ${ovpnFILE}
            fi
        done
    else
        echo "No OpenVPN config files."
        exit
fi

#write credentials
echo "${VPN_USER}" >> ${ovpnDIR}/cred.conf
echo "${VPN_PASS}" >> ${ovpnDIR}/cred.conf

openvpn --config ${ovpnFILE}