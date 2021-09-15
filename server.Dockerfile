FROM node:16-alpine
RUN apk update
RUN apk add git

RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
WORKDIR /home/node/app
USER node

RUN pwd
RUN git clone https://github.com/sefirosweb/minecraftLegionWebServer.git ./
RUN npm install --only=production

RUN cp .env_example .env

EXPOSE 4001
CMD [ "node", "index.js" ]