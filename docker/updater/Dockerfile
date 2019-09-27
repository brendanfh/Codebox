FROM node:12.9.1

RUN yarn global add coffeescript

COPY ./updater/package.json /app/package.json
WORKDIR /app
RUN yarn

COPY ./updater/main.js /app/main.js

ENV PATH $(yarn global bin):$PATH
