#!/bin/bash

DOMAIN=${DOMAIN:-api.opencdms.org}
EMAIL=${EMAIL:-info@opencdms.org}

certbot certonly --standalone -d $DOMAIN --email $EMAIL --agree-tos --no-eff-email
cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem /etc/nginx/ssl/nginx.crt
cp /etc/letsencrypt/live/$DOMAIN/privkey.pem /etc/nginx/ssl/nginx.key

nginx -t
service nginx start

while true; do
    sleep 12h & wait -n ${!}
    certbot renew
    cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem /etc/nginx/ssl/nginx.crt
    cp /etc/letsencrypt/live/$DOMAIN/privkey.pem /etc/nginx/ssl/nginx.key
    service nginx reload
done &

nginx -g "daemon off;"
