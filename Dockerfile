FROM alpine:latest

COPY ssh-key.pem key.pem

RUN apk add --no-cache openssh-client && \
    apk add --no-cache autossh && \
    (cd ~/ && mkdir .ssh/) && \
    echo "Host *" > ~/.ssh/config && \
    echo " StrictHostKeyChecking no" >> ~/.ssh/config && \
    chmod 444 ~/.ssh/config && \
    chmod 400 /key.pem

CMD autossh -M 5555 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -N -i /key.pem $REMOTE_USER@$REMOTE_IP -R $LOCAL_PORT:$HOST:$REMOTE_PORT -C
