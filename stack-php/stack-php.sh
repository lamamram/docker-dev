#!/bin/bash

#### SUPPRESSIONS #######
# test de l'existence des conteneurs si c'est vrai je supprime les conteneurs
# -q: affiche uniquement les identifiants
[[ -z $(docker ps -aq --filter name="stack-php-") ]] || docker rm -f $(docker ps -aq -f "name=stack-php-")

docker network ls | grep stack-php > /dev/null
if [[ "$?" -eq 0 ]]; then
  docker network rm stack-php
fi
#### RESEAU #####

docker network create \
       --driver=bridge \
       --subnet=172.18.0.0/24 \
       --gateway=172.18.0.1 \
       stack-php


#### CONTENEURS #######

docker run \
       --name stack-php-mariadb \
       -d --restart unless-stopped \
       --env MARIADB_USER=test \
       --env MARIADB_PASSWORD=roottoor \
       --env MARIADB_DATABASE=test \
       --env MARIADB_ROOT_PASSWORD=roottoor \
       --net stack-php \
       mariadb:11.7-ubi

docker run \
       --name stack-php-fpm \
       -d --restart unless-stopped \
       -v ./index.php:/srv/index.php \
       --net stack-php \
       bitnami/php-fpm:8.4-debian-12

docker run \
       --name stack-php-nginx \
       -d --restart unless-stopped \
       -p 8080:80 \
       -v ./vhost.conf:/etc/nginx/conf.d/vhost.conf \
       --net stack-php \
       nginx:1.27.4-bookworm
