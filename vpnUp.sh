#!/bin/bash

if [[ $EUID != 0 ]]; then
    echo "not sudo!"
    exit 1
fi
GATEWAY_IP=`( netstat -rn | awk '/default/ {if ( index($4, "en") > 0 ){print $2} }' )`
USER=username
echo $GATEWAY_IP
echo "P@ssword" | openconnect --user=$USER raeu03.ikea.com --passwd-on-stdin &
sleep 9s
VPN_INTERFACE=`( netstat -rn | awk '/default/ {if ( index($4, "utun") > 0 && index($2, "10") > 0){print $4} }' )`
route -nv add -net 10 -interface $VPN_INTERFACE
route change default $GATEWAY_IP
