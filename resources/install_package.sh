#!/bin/bash

# usage: ./install_package.sh <package_name> <ctan_url>

PACKAGE_NAME=$1
CTAN_URL=$2

mkdir -p ~/texmf/tex/latex/$PACKAGE_NAME

cd /tmp

wget $CTAN_URL
unzip $PACKAGE_NAME.zip
cd $PACKAGE_NAME

# generate sty files from ins/dtx if needed
[ -f *.ins ] && latex *.ins
[ ! -f *.ins ] && [ -f *.dtx ] && latex *.dtx

# copy and cleanup
cp *.sty ~/texmf/tex/latex/$PACKAGE_NAME/
cd ..
rm -rf $PACKAGE_NAME*

texhash ~/texmf