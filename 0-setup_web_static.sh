#!/usr/bin/env bash
# onfiguration de mon serveur  web_static

echo -e "\e[1;33m START\e[0m"

#--packages updating
sudo apt-get -y update
sudo apt-get -y install nginx
echo -e "\e[1;32m Packages à jour\e[0m"
echo

#--firewall
sudo ufw allow 'Nginx HTTP'
echo -e "\e[1;33m Nginx installé \e[0m"
echo

#--test shared
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
echo -e "\e[1;32m Creation du dossier de test et partage"
echo

#--teststes
echo "<h1>Welcome to bentalla.tech</h1>" > /data/web_static/releases/test/index.html
echo -e "\e[1;32m Fichier de test\e[0m"
echo

#--Ecrasement au cas ou
if [ -d "/data/web_static/current" ];
then
    echo "path /data/web_static/current exists"
    sudo rm -rf /data/web_static/current;
fi;
echo -e "\e[1;32m prevent overwrite\e[0m"
echo

#--creation lien symbolic
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -hR ubuntu:ubuntu /data

sudo sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

sudo ln -sf '/etc/nginx/sites-available/default' '/etc/nginx/sites-enabled/default'
echo -e "\e[1;32m Lien symbolic creer\e[0m"
echo

#--redemarrage NGINX
sudo service nginx restart
echo -e "\e[1;32m redemarrage de NGINX\e[0m"
