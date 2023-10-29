Unmaintened project. Please don't use it

# ribsInstallServer
This bash script install all necesaries for a web server on ubuntu distribution.
It will install : 
- apache2
- php7.4 with fpm
- php7.4-mysql
- php7.4-zip
- php7.4-xml
- php7.4-intl
- composer
- mariadb10.3
- curl
- nodejs8.x
- yarn

After all those things were installed, the scrpt will ask you if you want to create a
database user with all access on all url or on a specific database

## How to run it

First of all you have to download it

```bash
git clone https://github.com/Piou-piou/ribsInstallServer.git
```

After that you have to set it as executable file.
In the folder of the bash script do :

```bash
sudo chmod +x ribs-install-server.sh
```

And now to install a webserver on ubuntu distribution you just have to do (In the folder of the bash script) :

```bash
./ribs-install-server.sh webserver
```

After that if you got problem with mariadb. You just have to change the file /etc/mysql/mariadb.conf.d/50-server.cnf
and add this line `plugin-load-add = auth_socket.so` below `[mysqld]` section



## Create a config for a domain

To create a domain on ubuntu distribution you just have to do (In the folder of the bash script) :
This command is automaticly call on webserver command

```bash
./ribs-install-server.sh create-domain
```
