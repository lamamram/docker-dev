# communication entre Conteneurs

## réseau bridge par défaut "docker0"

* réseau interne installé par défaut en 172.17.0.1/16
  - 172.17.0.1 désigne l'hôte docker -> la vm
  - les conteneurs peuvent discuter sur ce réseau
* par défaut, les conteneurs peuvent **exposer** des ports réseau pour la comm inter conteneur sur le réseau interne, pas depuis l'extérieur
* pour accéder à un conteneur depuis l'extérieur, on doit **publier** les ports réseau 
  - option **-p** ou **--publish** : `docker run -p port_externe:port_interne`

  - ex: le conteneur devient accessible depuis le port 8080 sur toutes les interfaces de l'hôte

  ```
  docker run --name app_web -d --restart unless-stopped -p 8080:80 nginx:1.22
  ```
  - on peut spécifier une gamme de ports disponible, et même l'interface sur laquelle publier

  ```
  docker run --name app_web -d --restart unless-stopped -p 192.168.1.30:8080-8089:80 nginx:1.22
  ```

  - option **-P** ou **--publish-all**: un port random > 10000 disponible est selectionné pour tous les ports
    exposés


## communication inter conteneur sur docker0 : version manuelle

1. lancer un conteneur bitnami/php-fpm:7.4-debian-11 de nom app_php
  - `docker run --name app_php -d --restart unless-stopped bitnami/php-fpm:7.4-debian-11`
2. trouver l'ip du conteneur démarré
  - `docker inspect -f ...`
3. copier le fichier app_php.conf sur le conteneur nginx, en éditant les 2 ips 
  - `docker cp [src_path] [(container_name | container_id):dest_path]`
  - `docker cp /vagrant/confs/nginx/app_php.conf app_web:/etc/nginx/conf.d/app_php.conf`
  - verif: `docker exec -it app_web /bin/bash` puis `ls -al /etc/nginx/conf.d`
  - ou directement: `docker exec -it app_web ls -al /etc/nginx/conf.d`
4. copier le fichier index.php sur le conteneur php
  - `docker cp /vagrant/confs/php/index.php app_php:/srv/index.php`
5. relancer le conteneur nginx
  - docker restart app_web

## comm inter conteneur sur docker0: utilisation d'alias réseaux

1. le conteneur nginx dépend de la présence du conteneur php => commencer par le conteneur php
  - `docker run --name app_php -d --restart unless-stopped bitnami/php-fpm:7.4-debian-11`
  - `docker cp /vagrant/confs/php/index.php app_php:/srv/index.php`

2. on peut lancer nginx en lui indiquant un alias réseau pour le contneur php avec l'option **--link**
  - `docker run --name app_web -d --restart unless-stopped -p 192.168.1.30:8080:80 --link app_php nginx:1.22`
  - on peut aussi gérer soit même l'alias réseau avec `--link php.formation.lan:app_php`
  - il suffit de remplacer l'ip du conteneur php par l'alias "app_php" dans le fichier de conf


## les commandes docker network

1. voir les réseaux disponibles
  * `docker network ls`
  * il y a 3 réseaux par défaut:
    - le réseau bridge, de type bridge, interface docker0 172.17.0.1/24
    - le réseau host, qui redirige directement les conteneurs sur la vm (enp0S3 et enp0s8)
    - le réseau null, qui n'associe aucune interface ni aucune ip aux conteneurs

2. inspecter un réseau
  * `docker network inspect -f 'table {{ .Containers }}' bridge`

3. création d'un réseau custom:
  * `docker network create app_net`: dirver bridge par défaut, subnet 172.18.0.0 et gateway 172.18.0.1
  * `docker network create app_net --driver=bridge --subnet=172.19.0.0/24 --gateway=172.19.0.1`

4. connexion d'un conteneur à un réseau
  * `docker network connect app_net app_web`
  * `docker network disconnect app_net app_web`

5. communication inter conteneur sur un réseau bridge custom
  * ajout des conteneurs sur un réseau au lancement avec ip fixe ou non
    - `docker run ...... --net=[network_name] [--ip=[ip fixe]]`
    - `docker network connect ...`

  ```
  docker run --name app_web -d --restart unless-stopped -p 192.168.1.30:8080:80 --net=app_net nginx:1.22
  ```

  * sur un réseau bridge custom, les noms de conteneurs sont des alias réseaux par défaut => pas de **--link**