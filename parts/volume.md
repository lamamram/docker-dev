# Persistence des données des conteneurs

## enjeux

* les fichiers à l'intérieur du conteneur sont supprimées en même temps que le conteneur
* il peut être intéressant de définir des contenus persistents
* on appelle **volumes docker** les techniques permettant cela

## types de "volumes"

1. les "bind mounts": 
  * servent à injecter des contenus de type config gérés par l'utilisateur docker
  * on va associer des chemins à l'extérieur du conteneur à des chemins à l'intérieur du conteneur
    - syntaxe courte: `docker run ... -v [chemin_externe]:[chemin_interne]:ro`
    - syntaxe étendue: `docker run ... --mount key=value`
    ```
    --mount type=bind,
            src=/vagrant/confs/php/index.php,
            dest=/srv/index.php,
            readonly,
            ... options étendues
            volume-opt=driver=local,
            volume-opt=type=nfs
            volume-opt=device=192.168.x.y:/storage
    ```
