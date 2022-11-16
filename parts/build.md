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
* WORKDIR, USER: pour selecitonner l'utilisateur et le dossier home sur le conteneur
* EXPOSE pour déclarer les ports ouverts aux autres conteneurs
* ENTRYPOINT, CMD pour lancer une commande par défaut

* ENV, ARG: variables d'environnements et Argument renseignés en CLI

3. construire depuis le Dockerfile

* `docker build -t [image_name:tag_name] .` : exéuté depuis le dossier contenant le Dockerfile

*  `docker build --build-arg KEY=value -t [image_name:tag_name] .`: pour injecter des valeurs aux directives ARG