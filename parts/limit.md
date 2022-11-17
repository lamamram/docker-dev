# limitations des ressources conteneurs

## setup

* utilisation de l'image **progrium/stress**
  - `docker pull progrium/stress`
  - `docker run --rm progrium/stress --help`
* utilisation du paquet ctop
  - `sudo apt-get update && sudo apt-get install -y ctop`


## limiter l'accès mémoire

* `docker run --memory=xx(k,m,g)`
* option **--memory-swap** pour autoriser le swap pour le contneur
  - utilisation du stockage comme extension de la RAM (plus lent)
* option **--memory-reservation** pour établir une première limite dépassable transitoirement

* ex: `docker run -d --rm --memory=500m progrium/stress -m 1 --vm-bytes 250m -t 20s`
  - limitation phys de la RAM à 500M et exéc. d'un process allouant 250m pendant 20s

