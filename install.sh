#!/bin/bash

DOTFILES_DIR=~/dotfiles

declare -a files=("zshrc")

for file in "${files[@]}"; do
  ln -sfv "$DOTFILES_DIR/$file" ~/".$file"
done
