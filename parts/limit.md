# limitations des ressources conteneurs

## setup

* utilisation de l'image **progrium/stress**


## limiter l'accès mémoire

* `docker run --memory=xx(k,m,g)`
* option **--memory-swap** pour autoriser le swap pour le contneur
  - utilisation du stockage comme extension de la RAM (plus lent)
* option **--memory-reservation** pour établir une première limite dépassable transitoirement

