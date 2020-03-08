#!/bin/bash

printf " ##########################################\n"
printf " # AdBlocker Squid Proxy ##################\n"
printf " ##########################################\n"
printf " \n\n"

chown squid:squid /dev/stdout
chmod 644 /dev/stdout

(echo "@daily /updateAdServersList.sh") | crontab
/bin/bash /updateAdServersList.sh
/usr/sbin/squid -N -d1
