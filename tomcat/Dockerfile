FROM centos:7.9.2009

LABEL author=matt
LABEL created_at.year="2022"
LABEL created_at.month="2022-11"
LABEL stack="java_app"
LABEL stack.version="1.0.0"

# créer le dossier pour installer tomcat
# télécharger les binaires
# décompresser l'archive téléchargée
# déplacer les binaires dans le dossier tomcat
# mettre à jour le cache yum
# installer la dépendance java
# nettoyer le cache yum
# virer le tar et gz et le dossier decompressé

# RUN mkdir /opt/tomcat
# RUN curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.83/bin/apache-tomcat-8.5.83.tar.gz
# RUN tar -zxf apache-tomcat-8.5.83.tar.gz
# RUN mv apache-tomcat-8.5.83/* /opt/tomcat/
# RUN yum update -y
# RUN yum install java -yq
# RUN yum clean all
# RUN rm -rf apache-tomcat*

# optimiser les directives RUN pour minimiser le nb de couches de systèmes de fichiers
RUN mkdir /opt/tomcat && \
 curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.83/bin/apache-tomcat-8.5.83.tar.gz && \
 tar -zxf apache-tomcat-8.5.83.tar.gz && \
 mv apache-tomcat-8.5.83/* /opt/tomcat/ && \
 yum update -y && \
 yum install java -yq && \
 yum clean all && \
 rm -rf apache-tomcat*

# WORKDIR:  désignation du dossier à partir duquel:
#  - on exécute la directive CMD (et ENTRYPOINT)
#  - on exécute les commandes via docker exec ou docker run (avec ou sans -it)
WORKDIR /opt/tomcat/webapps

# possibilité de créer un utilisateur tomcat avec des droits d'exécution restreints
# à tomcat
# USER tomcat

# installation d'appications dans le repertoire dédié
RUN curl -O https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war

# déclarer un volume nommé depuis l'image pour persistence
VOLUME [ "/opt/tomcat/webapps" ]

# ouverture du conteneur sur le port tomcat par défaut
EXPOSE 8080

# lancer le serveur
# partie fixe de la commande, toujours exécutée par docker run
# - même si on exécute une commande dans le docker run
# Bonne pratique: exécuter un script de type entrypoint.sh qui 
# cusotmise l'initialisation et démarre le service
ENTRYPOINT [ "/opt/tomcat/bin/catalina.sh" ]
# partie dynamique de la commande, exécutée si le docker run n'exécute pas de commande
CMD [ "run" ]
