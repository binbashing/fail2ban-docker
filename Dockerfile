FROM alpine

# Update and upgrade packages
RUN apk update && apk upgrade

# Install fail2ban and moreutils
RUN apk add fail2ban curl moreutils envsubst

# Set default values for environment variables
ENV BANTIME=600
ENV FINDTIME=600
ENV MAXRETRY=5

# Copy the entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh

# Copy the fail2ban configuration files into the image
COPY jail.local /jail.local

# Set the entrypoint for the container
ENTRYPOINT ["/entrypoint.sh"]
