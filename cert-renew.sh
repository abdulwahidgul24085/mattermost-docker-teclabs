#!/bin/bash

cd /home/awg/mattermost-chatapp

docker compose -f docker-compose.yml -f docker-compose.nginx.yml down

docker run -it --rm --name certbot -p 80:80 \
    -v "${PWD}/certs/etc/letsencrypt:/etc/letsencrypt" \
    -v "${PWD}/certs/lib/letsencrypt:/var/lib/letsencrypt" \
    certbot/certbot certonly --standalone -d core.techlabs.cc \
    --force-renewal --non-interactive


docker compose -f docker-compose.yml -f docker-compose.nginx.yml up -d