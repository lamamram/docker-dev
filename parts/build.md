# Construction d'images

## Via Dockerfile

1. qu'est ce qu'une image ?

* représentation de l'état d'une partitition (snapshot)
* organisée comme un empilement de couches de systèmes de fichiers en lecture seule
* chaque couche est crée via une Directive du fichier Dockerfile
* le conteneur ajoute une fine couche de système de fichier en écriture sur l'image

2. le ficiher Dockerfile

* obligatoire: directive FROM image de base
* conseillé: directive LABEL pour ajouter des méta et filtrer les conteneurs
* COPY et RUN pour installer des fichiers et des paquets sur l'image
* optimiser les directies RUN
* WORKDIR, USER: pour selectionner l'utilisateur et le dossier home sur le conteneur
* EXPOSE pour déclarer les ports ouverts aux autres conteneurs
* ENTRYPOINT, CMD pour lancer une commande par défaut

* ENV, ARG: variables d'environnements et Argument renseignés en CLI

3. construire depuis le Dockerfile

* `docker build -t [image_name:tag_name] .` : exéuté depuis le dossier contenant le Dockerfile

*  `docker build --build-arg KEY=value -t [image_name:tag_name] .`: pour injecter des valeurs aux directives ARG

4. administration des images buildées

* si un build se passe mal, l'image peut se trouver sans nom ni tag => "dangling"
  - on peut filtrer la liste des images avec `docker image ls -f dangling=true`
  - on peut les supprimer avec `docker rmi $(docker images -f dangling=true -q)`

5. construction d'une image à partir d'un conteneur

* on lance un conteneur à partir d'une image de base
* on exécute dans le conteneur (-it) des commandes d'install / de config
* on nettoie avant de sortir
* on arrête si besoin le conteneur (status exited)
* `docker commit -a "author" -m "comment" [container_name] [image_name:tag_name]`
  - creation d'une nouvelle image à partir du conteneur précédent