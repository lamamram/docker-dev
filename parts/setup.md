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
  - `vagrant ssh formation.lan` pour cibles une connexion à une machine

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

