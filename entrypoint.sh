#!/bin/sh

handle_sigterm() {
    echo "SIGTERM received, stopping Fail2Ban server..."
    # Add any cleanup commands here before exiting
    /usr/bin/fail2ban-client stop
    exit 0
}

# Setup SIGTERM handler
trap handle_sigterm SIGTERM

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

# Keep script running to maintain control over the process and handle signals
wait $!