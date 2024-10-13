#!/bin/bash

# Usage: ./install_package.sh <package_name> <ctan_url>

PACKAGE_NAME=$1
CTAN_URL=$2

mkdir -p ~/texmf/tex/latex/$PACKAGE_NAME

cd /tmp

wget $CTAN_URL
unzip $PACKAGE_NAME.zip
cp $PACKAGE_NAME/*.sty ~/texmf/tex/latex/$PACKAGE_NAME/

rm -rf $PACKAGE_NAME*

texhash ~/texmf