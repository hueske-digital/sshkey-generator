FROM alpine:latest

RUN apk add --no-cache openssh

WORKDIR /root/.ssh

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]
