FROM jitesoft/node-yarn

WORKDIR /app

COPY ./small-front/. .

RUN yarn install

RUN yarn format

CMD ["yarn", "dev"]
