#!/bin/bash
# I was inspired to write this script after seeing Tom Bridge's Munki-in-a-box script in action
# https://github.com/tbridge/munki-in-a-box
# The ProxyTimeout value of 630 was suggested to try by Kerio Support
# The ProxyTimeout entry into the Custom site file was suggested by BunnyFu on Apple's support forum
# https://discussions.apple.com/thread/7331447 
# The method of putting ProxyTimeout into the apache proxy was suggested by Dr Greg Mulhauser
# https://codedmemes.com/lib/adjust-apache-proxy/
# This method is my attempt to fix a problem via-a-vis Kerio Connect and OS X SErver.app that neither company is currently fixing
# No warrantee is offered, either express or implied.
# Use at your own risk.
# Alex Narvey | Precursor.ca

MAILSERVERFQDN="server.example.com"
SERVERLOC="/Library/Server/Web/Config"
PROXYLOC="/Proxy"
SITESLOC="/apache2/sites"
PROXYDIR="${SERVERLOC}${PROXYLOC}"
SITESDIR="${SERVERLOC}${SITESLOC}"
PROXYCONFNAME="${PROXYDIR}/extra/proxy_timeout.conf"
SITECONFNAME="0000_127.0.0.1_34543_${MAILSERVERFQDN}.conf"
LOGGER="/usr/bin/logger -t Kerio-Connect-Proxy-Timeout-Fix"
TAB=$'\t'

echo "Welcome to the Kerio Connect 9 proxy timeout fix."'!'

echo "First up: Are you an admin user? Enter your password below:"
#This test is from To Bridge's Munki-in-a-box script...
sudo whoami > /tmp/quickytest

if
	[[  `cat /tmp/quickytest` == "root" ]]; then
	${LOGGER} "Privilege Escalation Allowed, Please Continue."
	else
	${LOGGER} "Privilege Escalation Denied, User Cannot Sudo."
	exit 1 "You are not an admin user, you need to do this an admin user."
fi

#Test that the mail server's Fully Qualified Domain Name (FQDN) was edited properly...
echo "First up: Test to see if you edited the mail server FQDN:"
echo "Please enter your mail server's Fully Qualified Domain Name (e.g. server.example.com):"
read FQDN
echo "Your FQDN name is ${FQDN}"
if
	[ "${FQDN}" == "${MAILSERVERFQDN}" ]; then
	echo "Bingo, you did edit your own mail server FQDN. Please Continue."
	${LOGGER} "Bingo, you did edit your own mail server FQDN. Please Continue."
	else
	echo "Notta, you did NOT edit your own mail server FQDN on line 14 before starting. Full Stop."
	${LOGGER} "Notta, you did NOT edit your own mail server FQDN on line 14 before starting. Full Stop."
	exit 1
fi

# Create the 'extra' directory
sudo mkdir -p ${PROXYDIR}/extra
echo "Making the extra folder in /Library/Server/Web/Config/Proxy"
${LOGGER} "Making the extra folder in ${PROXYDIR}"

# Create the 'proxy_timeout.conf' file
sudo touch ${PROXYDIR}/extra/proxy_timeout.conf
echo "Making the Proxy_Timeout.conf file"
${LOGGER} "Making the Proxy_Timeout.conf file"

# Edit the 'proxy_timeout.conf' file
cd ${PROXYDIR}/extra/
sudo chmod 646 proxy_timeout.conf
sudo echo "# Proxy Timeout Settings" > proxy_timeout.conf
sudo echo "ProxyTimeout 630" >> ${PROXYCONFNAME}
sudo chmod 644 proxy_timeout.conf
echo "Editing the Proxy_Timeout.conf file"
${LOGGER} "Editing the Proxy_Timeout.conf file"

# Place the include directive in the apache_serviceproxy.conf file
# Test the apache_serviceproxy.conf file to see if it is already edited for include statement
if grep --quiet /Library/Server/Web/Config/Proxy/extra/proxy_timeout.conf ${PROXYDIR}/apache_serviceproxy.conf; then
	echo "The include statement is already in there so we won't edit ${PROXYDIR}/apache_serviceproxy.conf"
	${LOGGER} "The include statement is already in there so we won't edit ${PROXYDIR}/apache_serviceproxy.conf"
	else
	# Put the include statement into the apache_serviceproxy.conf
	cd ${PROXYDIR}
	sudo chmod 646 apache_serviceproxy.conf	
	sudo sed -i '' $'10i\\\n# Begin Proxy Timeout Settings\n' ${PROXYDIR}/apache_serviceproxy.conf
	sudo sed -i '' $'11i\\\nInclude /Library/Server/Web/Config/Proxy/extra/proxy_timeout.conf\n\n' ${PROXYDIR}/apache_serviceproxy.conf
	sudo sed -i '' $'12i\\\n# End Proxy Timeout Settings\n' ${PROXYDIR}/apache_serviceproxy.conf
	sudo chmod 644 apache_serviceproxy.conf
	echo "Placing the include statement into the apache_serviceproxy.conf file"
fi

# Restart the Apache Proxy server
sudo /Applications/Server.app/Contents/ServerRoot/usr/sbin/serviceproxyctl restart
echo "Restarting the Apache Proxy server"
${LOGGER} "Restarting the Apache Proxy server"

# Stop the Web Service
sudo serveradmin stop web
echo "Stopping Web services"
${LOGGER} "Stopping Web services"

# Test the custom site file to see if it is already edited for ProxyTimeout
if grep --quiet ProxyTimeout ${SITESDIR}/${SITECONFNAME}; then
	echo "ProxyTimeout is already in there so we won't edit ${SITECONFNAME}"
	${LOGGER} "ProxyTimeout is already in there so we won't edit ${SITECONFNAME}"
	else
	# Fix the custom site file
	sudo sed -i '' $'2i\\\nProxyTimeout 630\n' ${SITESDIR}/${SITECONFNAME}
	echo "Editing the custom site file ${SITECONFNAME}"
	${LOGGER} "Editing the custom site file ${SITECONFNAME}"
fi

# Start the Web Service
sudo serveradmin start web
echo "Starting Web services"
${LOGGER} "Starting Web services"

# Completed
echo "Proxy Timeout fix is completed and you may test your webmail"
${LOGGER} "Proxy Timeout fix is completed and you may test your webmail"