# FROM scratch => pour les images de distro, ou app exec binaire (c / c++ / go ...)
FROM httpd:2.4

## documentation / filtre / configurations dynamiques
LABEL author="matt"
LABEL created="2025-03-18"
LABEL stack="java"
LABEL stack.version="1.0"

## écraser le httpd.conf natif de l'image de base avec ma propre conf
COPY ./httpd.conf /usr/local/apache2/conf

## ajouter le dossier /usr/local/apache2/conf/sites
RUN mkdir /usr/local/apache2/conf/sites

## ajouter le virtualhost tomcat

## déclarer les ports écoutés par le httpd
## 80 est vrai et 443 est faux => cf Listen de httpd.conf
EXPOSE 80 443

## lancement d'une commande est NON SUBSTITUABLE par la commande potentielle du docker run
# ENTRYPOINT [ "httpd", "-D", "FOREGROUND" ]
# ENTRYPOINT [ "httpd" ]
## créer un script de type entrypoint.sh pour préconfigurer le conteneur au lancement
# ENTRYPOINT [ "/.../.../docker-entrypoint.sh" ]
## lancement d'une commande est SUBSTITUABLE par la commande potentielle du docker run
CMD [ "httpd", "-D", "FOREGROUND" ]
# CMD [ "-D", "FOREGROUND" ]



