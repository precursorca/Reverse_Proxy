#!/bin/zsh
echo "List Apache included config files."
sudo apachectl -t -D DUMP_INCLUDES
echo "Apache included config files listed above."
