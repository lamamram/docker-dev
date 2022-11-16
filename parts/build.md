# Construction d'images

## Via Dockerfile

1. qu'est ce qu'une image ?

* représentation de l'état d'une partitition (snapshot)
* organisée comme un empilement de couches de systèmes de fichiers en lecture seule
* chaque couche est crée via une Directive du fichier Dockerfile
* le conteneur ajoute une fine couche de système de fichier en écriture sur l'image

2. le ficiher Dockerfile