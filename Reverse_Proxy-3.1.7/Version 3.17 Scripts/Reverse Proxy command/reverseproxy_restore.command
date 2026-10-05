#!/bin/zsh
#Set the variables
THEFILE="/private/etc/apache2/httpd.conf"
APACHE2_LOC="/private/etc/apache2"
EXTRA_LOC="extra"
SITES_LOC="sites"
CERTS_LOC="certificates"
HTTPD_FILE="httpd.conf"
SSL_FILE="httpd-ssl.conf"
VHOST_FILE="httpd-vhosts.conf"
BACKUP_LOC="/Users/Shared/ReverseProxy-Backup/"

echo "The Apache Config files used for ReverseProxy will be restored from ${BACKUP_LOC}" 

#Restore httpd.conf"
sudo cp "${BACKUP_LOC}${HTTPD_FILE}" "${APACHE2_LOC}/${HTTPD_FILE}"
sudo chown root "${APACHE2_LOC}/${HTTPD_FILE}"
#Restore httpd-ssl.conf"
sudo cp "${BACKUP_LOC}${SSL_FILE}" "${APACHE2_LOC}/${EXTRA_LOC}/${SSL_FILE}"
sudo chown root "${APACHE2_LOC}/${EXTRA_LOC}/${SSL_FILE}"
#Restore httpd-ssl.conf"
sudo cp "${BACKUP_LOC}${SSL_FILE}" "${APACHE2_LOC}/${EXTRA_LOC}/${SSL_FILE}"
sudo chown root "${APACHE2_LOC}/${EXTRA_LOC}/${SSL_FILE}"
#Restore httpd-vhost.conf"
sudo cp "${BACKUP_LOC}${VHOST_FILE}" "${APACHE2_LOC}/${EXTRA_LOC}/${VHOST_FILE}"
sudo chown root "${APACHE2_LOC}/${EXTRA_LOC}/${VHOST_FILE}"



#Restore sites files"
#make a directory for the site files
sudo mkdir /private/etc/apache2/sites
echo "Created a Sites folder"
sudo cp ${BACKUP_LOC}sites/* ${APACHE2_LOC}/${SITES_LOC}/ 

# Restore the .htpasswd (making it invisible for security)
sudo cp "${BACKUP_LOC}htpasswd" "${APACHE2_LOC}/.htpasswd"

#Restore certificates"
#make a directory for the certicates
sudo mkdir /private/etc/apache2/certificates
sudo cp ${BACKUP_LOC}certificates/* ${APACHE2_LOC}/${CERTS_LOC}/ 
echo "The Config files have been restored to ${APACHE2_LOC}"

#Restart apache to use restored config"
sudo apachectl restart
echo "Apache web services have been restarted."

