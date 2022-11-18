# Setup Docker Swarm

## principe

* on a besoin de trois machines , ou trois noeuds
  - un noeud **manager** qui permet de manipuler le cluster et d'héberger les services
  - deux noeuds **worker** qui hébergent des services
  - Rem: un clister peut avoir plusieurs noeuds manager

## mise en oeuvre

* voir Vagrantfile
  - ajout de deux tableaux de définition de machines (worker1 et worker2)
  - `vagrant up` crée ou lance les machines d'un coup
  - `vagrant ssh formation.lan` pour cibler une connexion à une machine
  - on provisionne la copie de la clé privée de windows vers formation.lan (cf infra)
  - on provisionne l'ajout des deux workers comme hôtes docker (cf infra)
    + script `add_machines.sh`

* installation de docker-machine sur le noeud formation.lan
  - ajout des commandes d'install au script `install_docker.sh`

* configuration des machines worker1.lan et worker2.lan comme hôte docker (install à distance)
  - on doit pouvoir communiquer entre les machines en ssh
    + la machine formation.lan doit contenir la clé privée utilisée par vagrant pour les commanes `vagrant ssh`
    + cette clé se trouve dans `C:\Users\[user]\.vagrant.d\insecure_private_key`
    + on copie cette clé dans le répertoire de travail
    + sur la machine formation.lan: `cp /vagrant/insecure_private_key ~/.ssh/`
    + la clé privée doit avoir comme droits 400: `chmod 400 ~/.ssh/insecure_private_key`
  - commande docker-machine pour installer à distance docker
  ```
  docker-machine create \
    --driver generic \
    --generic-ip-address 192.168.1.31 \
    --generic-ssh-user vagrant \
    --generic-ssh-key ~/.ssh/insecure_private_key \
    worker1
  ```

* quelques commandes docker-machine
  - `docker-machine ls`: afficher les hôtes docker reliés à la machine courante
  -  `docker-machine config`: config de connexion
  -  `docker-machine env [machine_name]`: retourne les export de variables d'env à exécuter pour rediriger la CLI docker sur le serveur docker (dockerd / daemon docker) de [machine_name]
  - `eval $(docker-machine env [machine_name])`: exécute les exports pour pointer sur une autre machine
    + dès lors les commandes docker sont exécutées sur la machine distante
  - `eval $(docker-machine env -u)`: revenir sur la machine cliente docker-machine (unset)
  - `docker-machine ssh [machine_name]`: connexion sur la machine distante

* test : déploiement de la stack php sur worker1
  ```
  eval $(docker-machine env worker1)
  cd /vagrant/stack_php
  docker compose up -d
  docker compose ps
  eval $(docker-machine env -u)
  ``` 

  - attention: les bind mounts (-v /src/:/dest/) fonctionnent car le dossier source /vagrant existe sur toutes les vm (fonctionnalité vagrant)
  - dans un cluster standard, il faut configurer un driver de volume donnant accès à une machine sur le réseau qui fournit les volumes (config avancée)
  - si le service ne démarre pas (nginx) penser à convertir les fichiers de conf en fin de ligne linux avec la commande `vim -c ":set ff=unix" -c ":wq" [file]`

