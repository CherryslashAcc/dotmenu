#!/bin/bash
set -e

SOURCE_FILE="dotmenu"
INSTALL_DIR="/usr/local/bin"
INSTALL_PATH="$INSTALL_DIR/$SOURCE_FILE"

if [ "$EUID" -ne 0 ]; then
  exec sudo "$0" "$@"
fi

echo "Starting installation of '$SOURCE_FILE'..."

if [ ! -f $SOURCE_FILE ]; then
    echo "ERROR: Main script '$SOURCE_FILE' not found."
    echo "Please run this installer from the same directory as the '$SOURCE_FILE' script."
    exit 1
fi

cp "$SOURCE_FILE" "$INSTALL_PATH"
echo "Copy made"
chmod +x "$INSTALL_PATH"

