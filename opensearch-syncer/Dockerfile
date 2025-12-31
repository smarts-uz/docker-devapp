FROM node:24-alpine

WORKDIR /app

COPY ./opensearch-syncer/package*.json ./

RUN npm install

COPY ./opensearch-syncer ./

RUN apk add --no-cache bash curl tzdata \
    && cp /usr/share/zoneinfo/Asia/Tashkent /etc/localtime \
    && echo "Asia/Tashkent" > /etc/timezone

CMD ["node", "start.js"]