FROM alpine

# Update and upgrade packages
RUN apk update && apk upgrade

# Install fail2ban and moreutils
RUN apk add fail2ban moreutils envsubst

# Copy the entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh

# Set the entrypoint for the container
ENTRYPOINT ["/entrypoint.sh"]
