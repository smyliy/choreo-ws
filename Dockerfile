FROM node:latest

WORKDIR /home/user

EXPOSE 3000

COPY files/* /home/user/

ENV PM2_HOME=/tmp

RUN apt-get update &&\
    apt install --only-upgrade linux-libc-dev &&\
    apt-get install -y iproute2 vim netcat-openbsd &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    addgroup --gid 10002 choreo &&\
    adduser --disabled-password  --no-create-home --uid 10002 --ingroup choreo user &&\
    usermod -aG sudo user &&\
    chmod +x index.js start.sh server &&\
    npm install -r package.json

CMD [ "node", "index.js" ]

USER 10002
