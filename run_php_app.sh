#!/bin/bash

prefix=app_
app_network=app_net

server_container=app_web
logic_container=app_php

# tester l'existence des conteneurs
# si oui, arrêt et suppression
[[ -z $(docker ps -f name=$prefix -aq) ]] || (docker stop $server_container $logic_container && docker rm $server_container $logic_container)

# on peut supprimer un réseau s'il n'a plus de conteneur en exécution
docker network rm $app_network
# vim -c ":set ff=unix" -c ":wq" run_php_app.sh pour changer crlf to lf

# création du réseau
docker network create $app_network \
    --driver=bridge \
    --subnet=172.19.0.0/24 \
    --gateway=172.19.0.1

# ajout des conteneurs + config
# logique
docker run --name $logic_container \
    -d --restart unless-stopped \
    --net=$app_network \
    -v /vagrant/confs/php/index.php:/srv/index.php:ro \
    bitnami/php-fpm:7.4-debian-11

# le volume permet de se passer de cette commande
# docker cp /vagrant/confs/php/index.php $logic_container:/srv/index.php

# server
docker run --name $server_container \
    -d --restart unless-stopped \
    -p 8080:80 \
    --net=app_net \
    nginx:1.22

docker cp /vagrant/confs/nginx/app_php.conf $server_container:/etc/nginx/conf.d/app_php.conf
docker restart $server_container
