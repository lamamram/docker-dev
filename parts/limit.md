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
* option **--memory-reservation** pour établir une quantité de mémoire minimale

* ex: `docker run -d --rm --memory=512m progrium/stress -m 1 --vm-bytes 256m -t 20s`
  - limitation phys de la RAM à 512M et exéc. d'un process allouant 256m pendant 20s
  - en exécutant de process, on prend le risque d'atteindre la lim phys ==> crash du conteneur
  - ajouter --memory-reservation à coté de --memory: permet d'allouer au moins telle quantité de RAM, vis à vis des autres conteneurs, sans garanties.

  ```
  docker run -d --rm \
    --memory=520m \
    --memory-reservation=256m \
    progrium/stress -m 1 --vm-bytes 256m -t 20s
  ```
