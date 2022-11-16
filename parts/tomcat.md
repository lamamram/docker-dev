# fabrication d'une image tomcat

1. Creer un répertoire tomcat
2. Créer un fichier Dockerfile
3. Schéma directeur:
    * Partir d'une image de base : centos:7.9
    * Préciser des labels (idéal pour donner des informations lors d'un docker image inspect)
    * Créer un répertoire /opt/tomcat
    * Récupérer le fichier exécutable : https://downloads.apache.org/tomcat/tomcat-8/v8.5.83/bin/apache-tomcat-8.5.83.tar.gz avec curl -O
    * Décompresser l'archive et déplacer tous le contenu dans /opt/tomcat/
    * Installer le package java avec yum install
    * Se positionner dans le répertoire "/opt/tomcat/webapps"
    * Récuperer l'app de test https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war>
    * Exposer le port 8080 pour tomcat
    * lancer le serveur (ENTRYPOINT + CMD) : doc tomcat pour la commande

----
> Idéalement : Essayer de minimiser le nombre de Layers !!

----

4. Construire une image nommée  tomcat:1.0 à partir de ce Dockerfile
5. Démarrer un nouveau conteneur à partir de cette image :
6. ajouter un vhost dans l'image httpd pour tester la cnx à tomcat
  * fichier tomcatsrv.conf à éditer
7. ajouter un vhost dans l'image httpd pour tester l'accès à l'appli .wat
  * fichier tomcatsample.conf à éditer
8. Tester l'accès depuis un navigateur sur le docker hôte (via httpd)