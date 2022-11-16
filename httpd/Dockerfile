# image de base à étendre
FROM httpd:2.4

# des labels (métadonnée) pour décrire l'image custom
# pour sélectionner les conteneurs en fonction des labels
# docker ps -f label=stack
# docker ps -f label=stack=java_app
LABEL author="matt"
LABEL created_at.year="2022"
LABEL created_at.month="2022-11"
LABEL stack="java_app"
LABEL stack.version="1.0.0"

# copie de fichiers ou dossier de l'extérieur vers l'image
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# créer le répertoire de vhosts avec une directive RUN
RUN mkdir /usr/local/apache2/conf/sites

# exposer un port (ouvrir sur les réseaux accesibles au conteneur)
# ici pas utile car l'image de base expose déjà le port
EXPOSE 80

# lancer le serveur au démarrage du conteneur
# REM: on lance les commandes au premier plan, puisqu'on est protégé par le conteneur
CMD [ "httpd", "-D", "FOREGROUND" ]