#!/bin/bash

app_network=java_net

server_container=httpd
logic_container=tomcat

# tester l'existence des conteneurs
# si oui, arrêt et suppression
[[ -z $(docker ps -aq) ]] || (docker stop $(docker ps -aq) && docker rm $(docker ps -aq))

# on peut supprimer un réseau s'il n'a plus de conteneur en exécution
# docker network rm $app_network
# suppression complète des réseaux ne contenant pas de conteneurs en exécution
docker network prune -f

# suppression du volume nommé s'il existe
# docker volume rm db_data
# suppression complète des volumes n'étant pas attachés à des conteneurs en exécution
docker volume prune -f

# vim -c ":set ff=unix" -c ":wq" run_php_app.sh pour changer crlf to lf

# création du réseau
docker network create $app_network \
    --driver=bridge \
    --subnet=172.20.0.0/24 \
    --gateway=172.20.0.1

# ajout des conteneurs + config

# logique
docker run --name $logic_container \
    -d --restart unless-stopped \
    --net=$app_network \
    java_tomcat:1.0

# server
docker run --name $server_container \
    -d --restart unless-stopped \
    -p 8081:80 \
    --net=$app_network \
    java_httpd:1.0
