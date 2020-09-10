FROM node:alpine AS node-base
WORKDIR /app
COPY package*.json ./
RUN npm install

FROM node-base AS node-build
COPY src ./src
COPY public ./public
RUN npm run build

FROM nginx:latest
COPY hosts /etc/nginx/conf.d
COPY --from=node-build /app/build /var/www/html