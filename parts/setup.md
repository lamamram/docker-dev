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