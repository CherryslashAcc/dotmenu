#!/bin/bash
set -e

SOURCE_FILE="dotmenu"
INSTALL_DIR="/usr/local/bin"
INSTALL_PATH="$INSTALL_DIR/$SOURCE_FILE"
DOTFILES_DIR="$HOME/dotfiles"
SOURCE_DOTFILES="dotfiles"

echo "Starting installation of '$SOURCE_FILE'..."

if [ ! -f $SOURCE_FILE ]; then
    echo "ERROR: Main script '$SOURCE_FILE' not found."
    echo "Please run this installer from the same directory as the '$SOURCE_FILE' script."
    exit 1
fi

if [ ! -d "$SOURCE_DOTFILES "]; then
  echo "Skipping..."
else
  if [ ! -e "$DOTFILES_DIR" ]; then
  cp -r "dotfiles" "$HOME/"
  else 
    echo "Found existing config directory."
    response=$(printf "Yes\nNo" | fzf --prompt="Create a backup?" --height="20%")
      case $response in 
        "Yes")
            mv "$DOTFILES_DIR" "${DOTFILES_DIR}_backup"
            ;;
        "No")
            rm -fr "$DOTFILES_DIR"
            ;;
        *)
            echo "Aborted. Exiting..."
            exit 1
            ;;1
     esac 
    cp "dotfiles" "${DOTFILES_DIR}"
  fi
fi
if [ "$EUID" -ne 0 ]; then
  exec sudo "$0" "$@"
fi
cp "$SOURCE_FILE" "$INSTALL_PATH"
echo "Copy made"
chmod +x "$INSTALL_PATH"

