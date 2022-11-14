# Cycle de vie des conteneurs

## lancer un conteneur "one shot"

1. on uitilise la commande `docker container run`
2. deux paramètres:
  * le nom d'une image de conteneur (dispo sur le [docker hub](https://hub.docker.com/))
  * une commande à exécuter à l'intérieur une fois le conteneur créé

```
docker container run alpine:latest echo "hello world !"
```

---

* Explication de la commande:
  1. docker cherche l'image en local
  2. sinon, il la télécharge (via `docker pull`)
  3. une image contient un **tag** qui précise la version ou la distrib de base
  4. une fois le conteneur créé, on exécute la commande en paramètre

---

* état du conteneur après exécution
  - après avoir exécuté sa commande, le conteneur stoppe son exécution
  - on ne peut plus rien exécuter dessus tant qu'on ne le redémarre pas
  - pour voir les conteneurs en exécution: `docker ps`
  - pour voir tous les conteneur existants: `docker ps -a`
  - pour supprimer un conteneur: `docker container rm [ID | NAME]`
  - pour lancer un conteneur pour exécution commande + suppression:
    * `docker container run --rm alpine:latest echo "hello world !"`

---
## lancer un conteneur en mode interactif

1. le mode interactif:
  *  option **-i** : bloque le processus à l'intérieur du conteneur sur le flux d'entrée
  * l'option **-t**: fournit un flux de sortie (tty) au process à l'intérieur du conteneur
  * bonne pratique: donner un nom au conteneur avec l'option --name [name]
  `docker container run --name alpine -it alpine:latest`

2. résultat:
  * on trouve on prompt sur le shell /bin/sh qui est la commande lancée par défaut avec l'image alpne
  * on remarque qu'on a plus un environnement ubuntu dans le conteneur
  * on sort du conteneur avec `exit`ou **CTRL+P+Q**