#!/bin/bash
# set -x

# usage: ./install_package.sh <package_name> <ctan_url>

PACKAGE_NAME=$1
CTAN_URL=$2

mkdir -p ~/texmf/tex/latex/$PACKAGE_NAME

cd /tmp

wget $CTAN_URL
unzip $PACKAGE_NAME.zip
cd $PACKAGE_NAME

# generate sty files from ins/dtx if needed
# first try using ins files, which is the standard method
for ins in *.ins; do
    [ -f "$ins" ] && latex "$ins"
done

# if no sty files generated, try dtx files
if ! ls *.sty >/dev/null 2>&1; then
    for dtx in *.dtx; do
        if [ -f "$dtx" ]; then
            # first try standard latex processing (existing behavior)
            latex "$dtx"
            
            # if that didn't work (circular dependency), try docstrip extraction
            if ! ls *.sty >/dev/null 2>&1; then
                # create a temporary docstrip file to extract the package
                echo '\input docstrip' > temp.ins
                echo '\generate{\file{'"$PACKAGE_NAME"'.sty}{\from{'"$PACKAGE_NAME"'.dtx}{package}}}' >> temp.ins
                echo '\endbatchfile' >> temp.ins
                
                # run the temporary file with latex
                latex temp.ins
            fi
        fi
    done
fi

# copy and cleanup
cp *.sty ~/texmf/tex/latex/$PACKAGE_NAME/ 2>/dev/null || echo "warning: no sty files generated"

# clean up
cd ..
rm -rf $PACKAGE_NAME*

texhash ~/texmf