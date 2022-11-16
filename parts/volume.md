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

2. les volumes nommés

> nom, étiquette qui désigne un dossier par défaut (driver local) dans /var/lib/docker/volumes géré par docker

* syntaxe rapide: `docker run ... -v [volume_name]:/path/to/dir`
* syntaxe étendue: --mount type=volume, src=[volume_name]
* création externe: `docker volume create [volume_name] --opt=...`

3. volumes anonymes:

* volume chargé dans un conteneur sans son nom
  - utilise le paramètre --volumes-from qui attache les volumes de conteneurs existant à un nouveau conteneur
  - utilisé pour le backup

* ex: backup de mariadb:
  - on utilise un conteneur 
  - éphémère (--rm) 
  - auquel on attache les volumes de la base de donnée (--volumes-from) 
  - pour exécuter le backup (tar cvf ...)
  - et le récupérer en dehors du conteneur (-v /vagrant:/backup)
  - `docker run --rm --name backup --volumes-from app_db -v /vagrant:/backup alpine:latest tar cvf /backup/maria.tar /var/lib/mysql`