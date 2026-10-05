#!/bin/zsh
#Set the variables
THEFILE="/private/etc/apache2/httpd.conf"
MODSSL="#LoadModule\ ssl_module\ libexec/apache2/mod_ssl.so"
MODPROXY="#LoadModule proxy_module libexec/apache2/mod_proxy.so"
MODREWRITE="#LoadModule rewrite_module libexec/apache2/mod_rewrite.so"
VHOSTINCLUDE="#Include /private/etc/apache2/extra/httpd-vhosts.conf"

#LoadModule socache_shmcb_module libexec\/apache2\/mod_socache_shmcb.so
#LoadModule proxy_connect_module libexec\/apache2\/mod_proxy_connect.so
#LoadModule remoteip_module libexec\/apache2\/mod_remoteip.so
#Let's see if this works...
#This isn't bulletproof, but this is a basic test.



#enable Mod_Proxy
sudo sed -i -e 's/#LoadModule proxy_module libexec\/apache2\/mod_proxy.so/LoadModule proxy_module libexec\/apache2\/mod_proxy.so/g' $THEFILE
echo "Mod_proxy has been enabled."
#enable Mod_Proxy_http
sudo sed -i -e 's/#LoadModule proxy_http_module libexec\/apache2\/mod_proxy_http.so/LoadModule proxy_http_module libexec\/apache2\/mod_proxy_http.so/g' $THEFILE
echo "Mod_proxy_http has been enabled."
#enable Mod_Proxy_Connect
sudo sed -i -e 's/#LoadModule proxy_connect_module libexec\/apache2\/mod_proxy_connect.so/LoadModule proxy_connect_module libexec\/apache2\/mod_proxy_connect.so/g' $THEFILE
echo "Mod_proxy_connect has been enabled."
#enable Mod_RemoteIP
sudo sed -i -e 's/#LoadModule remoteip_module libexec\/apache2\/mod_remoteip.so/LoadModule remoteip_module libexec\/apache2\/mod_remoteip.so/g' $THEFILE
echo "Mod_RemoteIP has been enabled."
#enable the Mod_Rewrite
sudo sed -i -e 's/#LoadModule rewrite_module libexec\/apache2\/mod_rewrite.so/LoadModule rewrite_module libexec\/apache2\/mod_rewrite.so/g' $THEFILE
echo "Mod-Rewrite file has been enabled."
#enable Mod_SSL
sudo sed -i -e 's/#LoadModule ssl_module libexec\/apache2\/mod_ssl.so/LoadModule ssl_module libexec\/apache2\/mod_ssl.so/g' $THEFILE
echo "Mod_SSL has been enabled."
#enable Mod_Include
sudo sed -i -e 's/#LoadModule include_module libexec\/apache2\/mod_include.so/LoadModule include_module libexec\/apache2\/mod_include.so/g' $THEFILE
echo "Mod_include has been enabled."
#enable Mod_socache_shmcb
sudo sed -i -e 's/#LoadModule socache_shmcb_module libexec\/apache2\/mod_socache_shmcb.so/LoadModule socache_shmcb_module libexec\/apache2\/mod_socache_shmcb.so/g' $THEFILE
echo "Mod_socache_shmcb has been enabled."
#enable HTTPD SSL Conf file
sudo sed -i -e 's/#Include \/private\/etc\/apache2\/extra\/httpd-ssl.conf/Include \/private\/etc\/apache2\/extra\/httpd-ssl.conf/g' $THEFILE
echo "The HTTPD SSL Conf file has been included."
#enable Virtual Hosts Config file
sudo sed -i -e 's/#Include \/private\/etc\/apache2\/extra\/httpd-vhosts.conf/Include \/private\/etc\/apache2\/extra\/httpd-vhosts.conf/g' $THEFILE
echo "The Virtual Host Config file has been included."

#disable Mod_HFS_Apple
sudo sed -i -e 's/LoadModule hfs_apple_module libexec\/apache2\/mod_hfs_apple.so/#LoadModule hfs_apple_module libexec\/apache2\/mod_hfs_apple.so/g' $THEFILE
echo "Mod_HFS_Apple has been disabled."

#make a directory for the site files
sudo mkdir /private/etc/apache2/sites
echo "Created a Sites folder"
#make a directory for the certicates
sudo mkdir /private/etc/apache2/certificates
echo "Created a Certificates folder"
# Get the path to the Directory where the sites_examples are
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
EXAMPLES="${DIR}/sites_examples"
# Get the sites_examples into the apache sites folder
cp "$EXAMPLES"/* /etc/apache2/sites/
chmod 644 /etc/apache2/sites/*.conf
echo "Copies of the example site files have been placed in the /etc/apache2/sites/ directory"
#backup default VHOSTS Conf file with date info
THEDATE=$( date "+%Y-%m-%d-%H-%M-%S")
mv /etc/apache2/extra/httpd-vhosts.conf /etc/apache2/extra/httpd-vhosts.conf_$THEDATE.bak
#set up the VHOSTS Conf file
cp "$DIR"/httpd-vhosts.conf /etc/apache2/extra/
chmod 644 /etc/apache2/extra/httpd-vhosts.conf
echo "The modified VHOSTS file has been placed in the /etc/apache2/extras/ directory"
echo "The installation is complete."