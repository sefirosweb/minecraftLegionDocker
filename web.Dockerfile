FROM node:16-alpine as building_production
RUN apk update
RUN apk add git

RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
WORKDIR /home/node/app
USER node

RUN pwd
RUN git clone https://github.com/sefirosweb/minecraftLegionWebClient.git ./
RUN npm install
RUN npm run build

FROM nginx:stable-alpine
COPY --from=building_production ["/home/node/app/build/", "/usr/share/nginx/html/"]
COPY ["./default.conf" , "/etc/nginx/conf.d/default.conf"]

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]   