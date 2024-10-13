#!/bin/bash

# Usage: ./install_font.sh <font_name> <url> [mode]
# mode: ctan (default) or raw

set -e

FONT_NAME=$1
URL=$2
MODE=${3:-ctan}

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

wget "$URL"
ZIP_FILE=$(ls *.zip)

if [ "$MODE" = "raw" ]; then
    mkdir -p /usr/share/fonts/truetype/$FONT_NAME
    unzip "$ZIP_FILE" -d /usr/share/fonts/truetype/$FONT_NAME
else
    mkdir -p ~/texmf/fonts/opentype/$FONT_NAME ~/texmf/tex/latex/$FONT_NAME
    unzip "$ZIP_FILE"
    cp -R $FONT_NAME/opentype/* ~/texmf/fonts/opentype/$FONT_NAME/ 2>/dev/null || true
    cp -R $FONT_NAME/latex/* ~/texmf/tex/latex/$FONT_NAME/ 2>/dev/null || true
fi

fc-cache -f
[ "$MODE" = "ctan" ] && texhash ~/texmf

echo "Installation of $FONT_NAME completed successfully"

# Cleanup
cd /
rm -rf "$TEMP_DIR"
