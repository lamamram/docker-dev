# Registre d'images privé

## principe

* on lance une stack comprenant
  - un serveur web: traefik, reverse proxy spécialisé pour les conteneurs
  - le registre d'image: registry

## config registry

- certificats ssl
- authentification par login: testuser, mdp: testpassword

## procédure d'enregistrement d'une image

* docker login URL -u [user] -p[passwd]
  - `docker login registry.lan:443 -u testuser ...`
* pour pousser une image, il faut renommer l'image avec
  - le nom de domaine du registre et le port réseau
  - ex: `docker tag java_httpd:1.0 registry.lan:443/java_httpd:1.0`
* pousser sur le registre: `docker push [image_name]`
