# Cycle de vie des conteneurs

## lancer un conteneur

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