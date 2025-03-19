## nous allons utiliser une image debian:12-slim
FROM debian:12-slim

## documenter l'image
LABEL author="matt"
LABEL created="2025-03-19"
LABEL stack="java"
LABEL stack.version="1.0"

## ces variables sont modifiables au moment du docker run !!!
ENV TRUC=machin

## ces variables sont modifiables au moment du docker build !!!
ARG TOMCAT_VERSION_MAJOR=9
ARG TOMCAT_VERSION_FULL

## BEST PRACTICE n°1: on place les couches qui change le - souvent
# installer java et nettoyer le dépôt
## BEST PRACTICE n°2: rassembler les commandes de création/modification/suppression dans les mêmes couches
# ajouter un dossier /opt/tomcat
# injecter le fichier https://downloads.apache.org/tomcat/tomcat-9/v9.0.102/bin/apache-tomcat-9.0.102.tar.gz dans ce dossier
# décomprésser dans ce dossier sans dossier intermédiaire 
# ADD https://downloads.apache.org/tomcat/tomcat-9/v9.0.102/bin/apache-tomcat-9.0.102.tar.gz /opt/tomcat
# ajouter un utilisateur tomcat avec le dossier /opt/tomcat comme home et un group tomcat
## BEST PRACTICE n°3: travailler en flux ( | ) et non en fichier !!!
# télécharger l'application sample https://tomcat.apache.org/tomcat-10.1-doc/appdev/sample/sample.war dans le dossier home 
# spécifier le propriétaire et groupe à tomcat 
RUN apt-get update -q && \
    apt-get install -y -q openjdk-17-jre-headless curl && \
    rm -rf /var/lib/apt/cache/lists/* && \
    mkdir /opt/tomcat && \
    curl https://downloads.apache.org/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION_FULL}/bin/apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz | \
    tar -xzv -C /opt/tomcat --strip-components=1 && \
    useradd -M -d /opt/tomcat -U tomcat && \
    curl https://tomcat.apache.org/tomcat-10.1-doc/appdev/sample/sample.war -o /opt/tomcat/webapps/sample.war && \
    chown -R tomcat:tomcat /opt/tomcat

## changer le home de l'image vers /opt/tomcat/webapps
WORKDIR /opt/tomcat/webapps

## changer l'utilisateur à tomcat
USER tomcat

## persister le dossier home pour accéder ou sauvegarder les apps
## ce volume géré par docker comme un volume nommé MAIS sans nom !!
## n'est utilisable qu'avec --volumes-from
VOLUME [ "/opt/tomcat/webapps" ]

## pour communiquer avec httpd avec le port 8080
EXPOSE 8080

## exécuter de manière statique (sans substitution) le binaire en foreground catalina.sh vs startup.sh ???
# ENTRYPOINT [ "/opt/tomcat/bin/catalina.sh" ]

## ajouter la sous commande pour lancer en one shot run ou start ???
CMD ["/opt/tomcat/bin/catalina.sh", "run" ]
