sudo apt -y update && sudo apt -y upgrade
sudo apt -y install lsb-release apt-transport-https ca-certificates
sudo apt install -y build-essential apache2 mariadb-server mariadb-client bison flex php php-curl php-cli php-common php-mysql php-pear php-gd php-mbstring php-intl php-ldap php-bcmath php-xml curl sox libncurses5-dev libssl-dev mpg123 libxml2-dev libnewt-dev sqlite3 libsqlite3-dev pkg-config automake libtool autoconf git unixodbc-dev uuid uuid-dev libasound2-dev libogg-dev libvorbis-dev libicu-dev libcurl4-openssl-dev libical-dev libneon27-dev libsrtp0-dev libspandsp-dev sudo subversion libtool-bin python-dev unixodbc dirmngr asterisk asterisk-config asterisk-core-sounds-ru asterisk-core-sounds-ru-g722 asterisk-core-sounds-ru-gsm asterisk-core-sounds-ru-wav asterisk-modules asterisk-mp3 asterisk-mysql asterisk-ooh323 asterisk-opus asterisk-voicemail nodejs

sudo systemctl restart asterisk
sudo systemctl disable asterisk
cd /usr/src
wget "https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz"
sudo tar xf ffmpeg-*.tar.xz
cd ffmpeg-*
sudo mv ffmpeg /usr/local/bin
sudo pear install Console_Getopt

sudo chown asterisk. /var/run/asterisk
sudo chown -R asterisk. /etc/asterisk
sudo chown -R asterisk. /var/{lib,log,spool}/asterisk

sudo chown -R asterisk. /usr/lib/asterisk
sudo systemctl stop asterisk
cd /etc/asterisk
sudo mkdir DIST
sudo mv * DIST
sudo cp DIST/asterisk.conf .
sudo sed -i 's/(!)//' asterisk.conf
sudo touch modules.conf
sudo touch cdr.conf
sudo touch /etc/asterisk/{modules,ari,statsd}.conf
sudo chown asterisk:asterisk /var/run/asterisk/*
sudo chmod 0777 /var/run/asterisk/*

sudo a2enmod php7.2
sudo sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.2/apache2/php.ini
sudo sed -i 's/\(^memory_limit = \).*/\1256M/' /etc/php/7.2/apache2/php.ini
sudo sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/apache2/apache2.conf
sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sudo a2enmod rewrite
sudo systemctl enable apache2
sudo rm /var/www/html/index.html
sudo systemctl restart apache2

sudo mysql_secure_installation

cd /usr/src
wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-15.0-latest.tgz
tar vxfz freepbx-*.tgz
rm -f freepbx-*.tgz
cd /usr/scr/freepbx*
sudo ./start_asterisk start

sudo mkdir /var/www/freepbx
sudo chown asterisk:asterisk /var/www/freepbx
sed -i 's/\/var\/www\/html/\/var\/www\/freepbx/g' /etc/apache2/sites-available/000-default.conf
sed -i 's/\/var\/www\/html/\/var\/www\/freepbx/g' /etc/apache2/sites-available/default-ssl.conf
./install --webroot=/var/www/freepbx -n

fwconsole ma installall
fwconsole reload




