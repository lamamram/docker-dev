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
  * on trouve un prompt sur le shell /bin/sh qui est la commande lancée par défaut avec l'image alpine
  * on remarque qu'on a plus un environnement ubuntu dans le conteneur
  * on sort du conteneur avec `exit`ou **CTRL+P+Q**

3. se connecter dans un conteneur existant
  * si stoppé, il faut démarrer le conteneur: `docker container start [ID | NAME]`
  * une fois démarrer, exécuter une commane one shot: `docker container exec [ID | NAME] [CMD]`
  * si on veut un prompt sur dans le conteneur: `docker container exec -it [ID | NAME] [CMD]`

4. stopper un conteneur avant de le supprimer
  *  un conteneur en état d'exécution (STATUS UP [duration] dans le docker ps) ne peut pas être supprimé
  * il faut d'abord le stopper: `docker stop [ID | NAME]`

---

REMARQUE: "container" est la sous commande par défaut: on peut l'omettre

---

## lancement de conteneur en mode détaché

1. pour les conteneurs abritant des process de type démon: serveurs qui écoutent sur un port
2. CtrL + C dans un conteneur arrête la commande et le conteneur
3. pour laisser un conteneur indépendant du processus qui l'a lancé (un shell)
  - **Ctrl + P + Q** en mode intéractif
  - lancer le `docker run` avec l'option **-d**: "detached"
  - le `docker start` démarre par défaut en mode détaché
4. pour les serveurs, ajouter l'option --restart unless-stopped
  - redémarre auto si crash
  - s'arrête sur un `docker stop`
  - redémarrage auto avec la machine hôte (service docker)

```
docker run --name demon -d --restart unless-stopped alpine:latest ping 8.8.8.8
```

## miscellanées sur la manipulation de conteneurs

1. téléchargement des images avant de lancer les conteneurs
  * `docker pull image:tag` : par défaut les images sont recherchées et téléchargées depuis <hub.docker.com>
  * `docker images` ou `docker image ls`: voir la liste des images docker en local
  * `docker rmi [image:tag] ou docker image rm [image:tag]` pour supprimer une image 
  * `docker image prune` : supprime toutes les images

2. docker run = docker create + docker start
  * `docker create` reprend les arguments de docker run en créant le conteneur sans le démarrer
  * `docker start` lance par défaut en mode détaché

3. filtrer les listes:
  * `docker ps [ --filter | -f ] [ name=regex | status=[running|exited|restarting...] | ancestor=image:tag]`
  * `docker images -f reference=n*: filtre les images selon leur nom avec des expressions globales (*, ** ...)`
  * utilisation pour stopper ou supprimer une grappe de conteneur
    - `docker stop $(docker ps -f status=restarting -q)`: arrêt des conteneurs à l'état restarting
    - `docker rm $(docker ps -a -f status=exited -q)` : suppression des conteneurs stoppés

4. introspection
  * afficher les logs d'exécution d'un conteneur: `docker logs [-f] [ID | NAME]`
  * inspecter la configuration du conteneur: `docker inspect [ID | NAME]`
   - formater l'objet d'inspection avec un template GO : `docker inspect -f '{{ .NetworkSettings.IPAddress }}' web_server`
   - ex. avec foramtage: `docker inspect -f '{{join .Args " "}}' web_server`: retourne la commande lancée au démarrage

