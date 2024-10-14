#!/bin/bash

# Usage: ./install_font.sh <mode> <font_name> <SOURCE_RES>
# mode: ctan, zip, or dir

set -e

if [ $# -lt 3 ]; then
    echo "Usage: $0 <mode> <font_name> <SOURCE_RES>"
    echo "mode: ctan, zip, or dir"
    exit 1
fi

MODE=$1
FONT_NAME=$2
SOURCE_RES=$3

TEMP_DIR=$(mktemp -d)

install_font_files() {
    local src_dir=$1
    local ttf_count=$(find "$src_dir" -type f \( -name "*.ttf" -o -name "*.ttc" \) | wc -l)
    local otf_count=$(find "$src_dir" -type f -name "*.otf" | wc -l)

    if [ $ttf_count -gt 0 ]; then
        mkdir -p "/usr/share/fonts/truetype/$FONT_NAME"
        find "$src_dir" -type f \( -name "*.ttf" -o -name "*.ttc" \) -exec cp {} "/usr/share/fonts/truetype/$FONT_NAME" \;
        echo "TrueType fonts installed to /usr/share/fonts/truetype/$FONT_NAME"
    fi

    if [ $otf_count -gt 0 ]; then
        mkdir -p "/usr/share/fonts/opentype/$FONT_NAME"
        find "$src_dir" -type f -name "*.otf" -exec cp {} "/usr/share/fonts/opentype/$FONT_NAME" \;
        echo "OpenType fonts installed to /usr/share/fonts/opentype/$FONT_NAME"
    fi

    if [ $ttf_count -eq 0 ] && [ $otf_count -eq 0 ]; then
        echo "No TrueType or OpenType fonts found in the source."
    fi
}

extract_zip() {
    local zip_file=$1
    local extract_dir=$2
    unzip "$zip_file" -d "$extract_dir"
}

if [ "$MODE" = "zip" ]; then
    cd "$TEMP_DIR"
    wget "$SOURCE_RES"
    extract_zip *.zip "$TEMP_DIR"
    install_font_files "$TEMP_DIR"
elif [ "$MODE" = "dir" ]; then
    if [ ! -d "$SOURCE_RES" ]; then
        echo "Error: Specified directory does not exist."
        exit 1
    fi
    install_font_files "$SOURCE_RES"
elif [ "$MODE" = "ctan" ]; then
    mkdir -p ~/texmf/fonts/opentype/$FONT_NAME ~/texmf/tex/latex/$FONT_NAME
    cd "$TEMP_DIR"

    if [[ "$SOURCE_RES" == http* ]]; then
        wget "$SOURCE_RES"
        extract_zip *.zip "$TEMP_DIR"
    elif [[ "$SOURCE_RES" == *.zip ]]; then
        if [ ! -f "$SOURCE_RES" ]; then
            echo "Error: Specified ZIP file does not exist."
            exit 1
        fi
        extract_zip "$SOURCE_RES" "$TEMP_DIR"
    else
        echo "Error: Invalid source for CTAN mode. Use a URL or a local ZIP file."
        exit 1
    fi

    cp -R $FONT_NAME/opentype/* ~/texmf/fonts/opentype/$FONT_NAME/ 2>/dev/null || true

    if [ -d "$FONT_NAME/latex" ]; then
        cp -R $FONT_NAME/latex/* ~/texmf/tex/latex/$FONT_NAME/ 2>/dev/null || true
    elif [ -d "$FONT_NAME/tex" ]; then
        cp -R $FONT_NAME/tex/* ~/texmf/tex/latex/$FONT_NAME/ 2>/dev/null || true
    else
        echo "Warning: Neither /latex nor /tex subfolder found."
    fi
else
    echo "Error: Invalid mode. Use 'ctan', 'zip', or 'dir'."
    exit 1
fi

fc-cache -f
[ "$MODE" = "ctan" ] && texhash ~/texmf

echo "Installation of $FONT_NAME completed successfully"

# Cleanup
cd /
rm -rf "$TEMP_DIR"
