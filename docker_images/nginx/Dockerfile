FROM nginx:1.18.0-alpine

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/mime.types /etc/nginx/mime.types
COPY conf/conf.d/server.key /etc/nginx/conf.d/server.key
COPY conf/conf.d/server.pem /etc/nginx/conf.d/server.pem