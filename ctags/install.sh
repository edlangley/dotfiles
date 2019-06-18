#!/bin/sh

mkdir -p ~/not_backed_up/tags_cscope_databases
cp ~/.dotfiles/ctags/file_extensions_to_tag.txt ~/not_backed_up/tags_cscope_databases
sudo apt install cscope exuberant-ctags

