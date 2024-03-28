#!/bin/sh

envsubst < /jail.conf | sponge /etc/fail2ban/jail.conf

if [ $? -ne 0 ]; then
    echo "Error: Failed to substitute environment variables in jail.conf"
    exit 1
fi

# Start Fail2Ban
/usr/bin/fail2ban-server -f -x -v start

if [ $? -ne 0 ]; then
    echo "Error: Failed to start Fail2Ban server"
    exit 1
fi