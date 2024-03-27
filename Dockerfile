FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add fail2ban

ENTRYPOINT ["/usr/bin/fail2ban-server", "-f", "-x", "-v", "start" ]
