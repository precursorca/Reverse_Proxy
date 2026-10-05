#!/bin/zsh
# Variables
osvers=$(sw_vers -productVersion | awk -F. '{print $2}') # Thanks Rich Trouton
minorosvers=$(sw_vers -productVersion)
apacheVersion=$(apachectl -V | awk 'NR==1{print $3}' | awk -F'/' '{print $2}')
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo "macOS ${minorosvers}"
echo "Apache: ${apacheVersion}"
