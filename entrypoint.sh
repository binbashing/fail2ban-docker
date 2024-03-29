#!/bin/sh

set -e

handle_sigterm() {
    echo "SIGTERM received, stopping Fail2Ban server..."
    /usr/bin/fail2ban-client stop
    exit 0
}

# Setup SIGTERM handler
trap handle_sigterm SIGTERM

envsubst < /jail.conf | sponge /etc/fail2ban/jail.conf

# Start Fail2Ban
/usr/bin/fail2ban-server -f -x -v start

# Keep script running to maintain control over the process and handle signals
wait $!