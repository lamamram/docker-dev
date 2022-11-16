FROM centos:7.9.2009

LABEL author=matt
LABEL created_at.year="2022"
LABEL created_at.month="2022-11"
LABEL stack="java_app"
LABEL stack.version="1.0.0"

# créer le dossier pour installer tomcat
RUN mkdir /opt/tomcat
# télécharger les binaires
RUN curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.83/bin/apache-tomcat-8.5.83.tar.gz
# décompresser l'archive téléchargée
RUN tar -zxf apache-tomcat-8.5.83.tar.gz
# déplacer les binaires dans le dossier tomcat
RUN mv apache-tomcat-8.5.83/* /opt/tomcat/
# mettre à jour le cache yum
RUN yum update -y
# installer la dépendance java
RUN yum install java -yq
# nettoyer le cache yum
RUN yum clean all
# virer le tar et gz et le dossier decompressé
RUN rm -rf apache-tomcat*
