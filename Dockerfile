FROM node:lts-alpine AS build
WORKDIR /usr/src/app

ARG BASE_URL=/

COPY package*.json ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build --base=${BASE_URL}


FROM nginxinc/nginx-unprivileged:stable-alpine
EXPOSE 8080

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
