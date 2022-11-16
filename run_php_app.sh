#!/bin/bash

prefix=app_
app_network=app_net

server_container=app_web
logic_container=app_php
db_container=app_db

# tester l'existence des conteneurs
# si oui, arrêt et suppression
[[ -z $(docker ps -f name=$prefix -aq) ]] || (docker stop $(docker ps -f name=$prefix -aq) && docker rm $(docker ps -f name=$prefix -aq))

# on peut supprimer un réseau s'il n'a plus de conteneur en exécution
docker network rm $app_network
# vim -c ":set ff=unix" -c ":wq" run_php_app.sh pour changer crlf to lf

# création du réseau
docker network create $app_network \
    --driver=bridge \
    --subnet=172.19.0.0/24 \
    --gateway=172.19.0.1

# ajout des conteneurs + config
# base de données

# --env: variable d'environnement disponible uniquement dans l'environnement d'exécution au lancement du conteneur
# -v: bind mount qui permet d'initialiser la base de donnée au lancement: le contenu de
# docker-entrypoint-initdb.d sera exécuté par ordre alphabétique
# -v db_data: volume nommé: récupération sur la vm de la base pour backup / restore
# --env MARIADB_ROOT_PASSWORD=roottoor \
# on préferera --env-file pour charger un fichier contenant plusieurs variables
# d'environnment et ainsi cacher leurs valeurs 
docker run --name app_db \
    -d --restart unless-stopped \
    --net=$app_network \
    --env-file /vagrant/.env
    -v db_data:/var/lib/mysql \
    -v /vagrant/confs/mariadb/test.sql:/docker-entrypoint-initdb.d/test.sql \
    mariadb:10.6-focal


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
    -v /vagrant/confs/nginx/app_php.conf:/etc/nginx/conf.d/app_php.conf:ro \
    nginx:1.22           

# docker cp /vagrant/confs/nginx/app_php.conf $server_container:/etc/nginx/conf.d/app_php.conf
# docker restart $server_container
