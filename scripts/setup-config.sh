#!/usr/bin/env bash

# Set your dotfiles repo path
DOTFILES="$HOME/dotfiles"

# List of .config directories to symlink
CONFIGS=(
  swayidle
  waybar
  fish
  kitty
  ripgrep
  niri
  nvim
  scripts
  wallpapers
  tmux
)

# Symlink each config directory to ~/.config/
for item in "${CONFIGS[@]}"; do
  SRC="$DOTFILES/$item"
  DEST="$HOME/.config/$item"
  if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
    echo "Backing up existing $DEST to $DEST.bak"
    mv "$DEST" "$DEST.bak"
  fi
  if [ -L "$DEST" ]; then
    rm "$DEST"
  fi
  ln -sfn "$SRC" "$DEST"
  echo "Symlinked $SRC -> $DEST"
done

# Symlink kanata.kbd from kanata/ to /etc/kanata.kbd
KANATA_SRC="$DOTFILES/kanata/kanata.kbd"
KANATA_DEST="/etc/kanata.kbd"
if [ -e "$KANATA_DEST" ] && [ ! -L "$KANATA_DEST" ]; then
  echo "Backing up existing $KANATA_DEST to $KANATA_DEST.bak"
  sudo mv "$KANATA_DEST" "$KANATA_DEST.bak"
fi
if [ -L "$KANATA_DEST" ]; then
  sudo rm "$KANATA_DEST"
fi
sudo ln -sfn "$KANATA_SRC" "$KANATA_DEST"
echo "Symlinked $KANATA_SRC -> $KANATA_DEST"
