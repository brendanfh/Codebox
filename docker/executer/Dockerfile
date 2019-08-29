FROM node:12.9.1

RUN yarn global add coffeescript \
	&& apt-get update \
	&& apt-get install -y libseccomp-dev python3

COPY ./executer/package.json /app/package.json
WORKDIR /app
RUN yarn

COPY ./executer/Tupfile /app/Tupfile
COPY ./executer/Tuprules.tup /app/Tuprules.tup
COPY ./executer/main.js /app/main.js
COPY ./executer/app /app/app

ENV PATH $(yarn global bin):$PATH
