FROM node:12.9.1

RUN yarn global add coffeescript \
	&& apt-get update \
	&& apt-get install -y libseccomp-dev python3

COPY ./executer/package.json /app/package.json
WORKDIR /app
RUN yarn

COPY ./executer/main.js /app/main.js
COPY ./executer/app /app/app

ENV PATH $(yarn global bin):$PATH
