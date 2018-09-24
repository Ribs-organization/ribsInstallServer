# ribsInstallServer
This bash script install all necesaries for a web server on ubuntu distribution.
It will install : 
- apache2
- php7.2 with fpm
- php7.2-mysql
- php7.2-zip
- php7.2-xml
- php7.2-intl
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

## Create a config for a domain

To create a domain on ubuntu distribution you just have to do (In the folder of the bash script) :
This command is automaticly call on webserver command

```bash
./ribs-install-server.sh create-domain
```