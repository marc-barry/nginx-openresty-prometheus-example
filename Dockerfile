FROM middlenamesfirst/docker-nginx-openresty:1.15.4-1-mainline-alpine

COPY nginx.conf /etc/nginx/
COPY src/lua /etc/nginx/conf.d/lua