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


## communication inter conteneur sur docker0

* lancer un conteneur php-fpm:7.4-debian-11 de nom app_php
* trouver l'ip du conteneur démarré