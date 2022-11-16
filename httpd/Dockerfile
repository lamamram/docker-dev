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