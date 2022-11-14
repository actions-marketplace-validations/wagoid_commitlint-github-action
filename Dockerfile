FROM node:18.3.0-alpine3.14 as build

COPY package*.json /

RUN npm ci --ignore-scripts

COPY . .

RUN npm run build

FROM node:18.3.0-alpine3.14

RUN apk --no-cache add git

COPY --from=build dist/run.js /run.js

COPY package*.json /

RUN npm ci --production --ignore-scripts

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
