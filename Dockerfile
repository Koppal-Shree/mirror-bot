FROM alpine:latest

# install ca-certificates so that HTTPS works consistently
RUN apk add --no-cache ca-certificates

RUN apk add --no-cache --update \
      git \
      bash \
      nodejs \
      npm \
      aria2

# To handle not get uid/gid error while installing a npm package
RUN npm config set unsafe-perm true

RUN npm install -g typescript

RUN mkdir /bot
RUN chmod 777 /bot
WORKDIR /bot

RUN git clone https://github.com/newwalahai1/aria-telegram-mirror-bot /bot

COPY ./src/.constants.js /bot/src/
COPY ./aria*.sh ./client_secret.json ./credentials.json ./start.sh /bot/

RUN cd /bot
RUN npm install && tsc

CMD ["bash","start.sh"]
