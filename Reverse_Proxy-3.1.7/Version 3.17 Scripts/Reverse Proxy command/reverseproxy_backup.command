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

echo "The Apache Config files used for ReverseProxy will be backed up to ${BACKUP_LOC}" 

# Make Backup folders
mkdir ${BACKUP_LOC}
mkdir ${BACKUP_LOC}${SITES_LOC}
mkdir ${BACKUP_LOC}${CERTS_LOC}
# Backup httpd.conf
sudo cp "${APACHE2_LOC}/${HTTPD_FILE}" "${BACKUP_LOC}${HTTPD_FILE}"
# Backup httpd-ssl.conf
sudo cp "${APACHE2_LOC}/${EXTRA_LOC}/${SSL_FILE}" "${BACKUP_LOC}${SSL_FILE}"
# Backup httpd-vhost.conf
sudo cp "${APACHE2_LOC}/${EXTRA_LOC}/${VHOST_FILE}" "${BACKUP_LOC}${VHOST_FILE}"

# Backup .htpasswd (making it visible so we don't forget it)
sudo cp "${APACHE2_LOC}/.htpasswd" "${BACKUP_LOC}htpasswd"

# Backup sites files
#sudo cp /private/etc/apache2/sites/* ${BACKUP_LOC}sites
sudo cp ${APACHE2_LOC}/${SITES_LOC}/* ${BACKUP_LOC}sites

# Backup certificates
sudo cp ${APACHE2_LOC}/${CERTS_LOC}/* ${BACKUP_LOC}certificates

echo "The Config files have been backed up to ${BACKUP_LOC}" 
exit 0