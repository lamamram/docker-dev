# communication entre Conteneurs

## réseau bridge par défaut "docker0"

* réseau interne installé par défaut en 172.17.0.1/16
  - 172.17.0.1 désigne l'hôte docker -> la vm
  - les conteneurs peuvent discuter sur ce réseau
  - par défaut, les conteneurs peuvent **exposer** des ports réseau pour la comm inter conteneur sur le réseau interne, pas depuis l'extérieur
  - pour accéder à un conteneur depuis l'extérieur, on doit **publier** les ports réseau grâce à l'option **-p** ou **--publish** du docker run
