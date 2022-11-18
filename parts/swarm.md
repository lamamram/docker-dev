# Docker Swarm

## lancement des machines

* après le setup,
  - `vagrant destroy -f` pour supprimer toutes les machines
  - `vagrant up` pour:
     + création de trois vms worker1.lan, worker2.lan, formation.lan
     + ajout de la clé privée de Windows à formation.lan
     + installation de docker + docker-machine sur formation.lan
     + ajouts de worker1 et worker2 comme hôtes docker via docker-machine
  - attention: sur les noeuds workers: toutes commandes docker en sudo
  - attention: sur formation.lan: docker-machine en sudo, autre docker normal

## création du cluster

1. création d'un noeud de type **manager**
  * sur formation.lan: `docker swarm init --advertise-addr [ip de formation.lan]`
  * voir les noeuds du cluster: `docker node ls`

2. ajout d'un noeud de type **worker** au cluster
  * se rendre sur la machine: `sudo docker-machine ssh workeri`
  * exécuter
  ```
   docker swarm join --token SWMTKN-1-[SEPCIFIC_TOKEN] [manager_ip]:2377
  ```

## lancement d'un service sur le cluster

