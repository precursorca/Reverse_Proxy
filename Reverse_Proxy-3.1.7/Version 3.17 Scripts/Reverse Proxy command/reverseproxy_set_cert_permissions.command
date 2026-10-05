#!/bin/zsh
#set the owner to root and the group to wheel for all certificates in the certificates folder
sudo find /private/etc/apache2/certificates -type f -exec chown root:wheel {} \;
#set the correct permissions for all certificates in the certificates folder
sudo find /private/etc/apache2/certificates -type f -exec chmod 644 {} \;
echo "The correct permissions are now set on all certificates in the Apache certificates folder."
