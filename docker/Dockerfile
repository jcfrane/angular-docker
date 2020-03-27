# Build  Image

FROM node:13.10.1-alpine3.11 as build

WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

COPY ./package.json /app/package.json
RUN npm install
RUN npm install -g @angular/cli@v9.0.x

COPY ./ /app

RUN ng build --prod --output-path=dist

# Dev Image

FROM build as dev
EXPOSE 80
COPY ./docker/dev-entrypoint.sh /
ENTRYPOINT ["/bin/sh", "/dev-entrypoint.sh"]

# App Image

FROM nginx:alpine as prod

RUN apk update && \
  apk add --no-cache make gettext
  
COPY ./docker/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

COPY ./docker/entrypoint*.sh /
RUN chmod +x /entrypoint*.sh

EXPOSE 80 443
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]


