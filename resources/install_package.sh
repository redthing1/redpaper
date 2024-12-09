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
for ins in *.ins; do
    [ -f "$ins" ] && latex "$ins"
done

# if no sty files generated, try dtx files
if ! ls *.sty >/dev/null 2>&1; then
    for dtx in *.dtx; do
        [ -f "$dtx" ] && latex "$dtx"
    done
fi

# copy and cleanup
cp *.sty ~/texmf/tex/latex/$PACKAGE_NAME/
cd ..
rm -rf $PACKAGE_NAME*

texhash ~/texmf