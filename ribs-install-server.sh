#!/usr/bin/env bash

CYAN='\033[00;36m'
WHITE='\033[01;37m'

setTitre() {
    echo -e ""
    echo -e "${CYAN}------------------------------------------------"
    echo -e $1
    echo -e "------------------------------------------------"
    echo -e "${WHITE}"
}

installDatabase() {
    setTitre "Souhaitez créer un utilisateur pour la base de données avec une base ?"

    read -n1 -p "y pour oui | n pour non : " creer_bdd
    case $creer_bdd in
      y|Y)
            setTitre "Mise en place de la base de données"
            echo "Entrez un nom d'utilisateur et un mot de passe pour la base de données"
            read -p "Nom d'utilisateur : " bdd_user
            read -sp "Mot de passe : " bdd_password
            echo ""
            read -p "lui donner tous les privileges (1) | creer juste une base avec son accès (2) : " privileges
            read -p "lui donner accès seulement en local (1) | accès de partout (2) : " acces

            create_bdd=true
       ;;
      n|N)  ;;
      *) create_bdd=false ;;
    esac

    if [ "$create_bdd" = "true" ]
    then
        if [ "$privileges" = "1" ]
        then
            bdd_name="%"
        elif [ "$privileges" = "2" ]
        then
            read -p "Donnez le nom de la bdd à créer : " bdd_name
            mysql -uroot -p -e "CREATE DATABASE ${bdd_name};"
        fi

        if [ "$acces" = "1" ]
        then
            hostname="127.0.0.1"
        elif [ "$acces" = "2" ]
        then
            hostname="%"
        fi

        mysql -uroot -p -e "CREATE USER '${bdd_user}'@'${hostname}' IDENTIFIED BY '${bdd_password}';GRANT ALL PRIVILEGES ON ${bdd_name}. * TO '${bdd_user}'@'${hostname}';FLUSH PRIVILEGES;"
    fi
}

installWebserver() {
    setTitre "L'installation du serveur web a été lancée"

    setTitre "Mise à jour du serveur"
    sudo apt-get update && apt-get upgrade

    setTitre "Installation apache 2 mariadb php7.2"
    sudo apt install apache2 mariadb-server php7.2 php7.2-fpm curl

    setTitre "Installation des dépendances PHP7.2"
    sudo apt install php7.2-mysql php7.2-zip php7.2-xml php7.2-intl libpng-dev php-imagick

    setTitre "Installation de composer"
    sudo apt install composer

    setTitre "Installation de nodejs"
    sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    sudo apt install -y nodejs

    setTitre "Installation de yarn"
    sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn

    setTitre "Mise en place de php fpm"
    sudo a2enmod proxy_fcgi setenvif
    sudo a2enconf php7.2-fpm
    sudo a2dismod php7.2

    setTitre "Update à mariadb 10.3"
    sudo apt-get install software-properties-common
    sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
    sudo add-apt-repository 'deb [arch=amd64,arm64,i386,ppc64el] http://mariadb.mirrors.ovh.net/MariaDB/repo/10.3/ubuntu xenial main'
    sudo apt-get update
    sudo apt-get install mariadb-server -y

    reloadservice
    installDatabase
}

reloadservice() {
    setTitre "Reload php-fpm + apache2"
    sudo service php7.2-fpm reload
    sudo service apache2 reload
}

helpermore(){
    setTitre "Commandes disponibles"
    echo "install-webserver: Permet d'installer un serveur web (apache2, php7.2-fpm, mariadb, ...) sur un distrib ubuntu"
    echo "help | -h | --help: Affiche des informations sur les commandes disponibles"
}

if [ "$1" = "install-webserver" ]
then
    installWebserver
elif [ "$1" = "-h" ] || [ "$1" = "help" ] || [ "$1" = "--help" ]
then
    helpermore
else
    helpermore
fi
