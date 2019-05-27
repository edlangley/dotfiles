#!/bin/sh

git config --global merge.tool "meld3"
git config --global mergetool.meld3.cmd '$HOME/.dotfiles/bin/gitmeld3merge.sh $BASE $LOCAL $REMOTE $MERGED'
git config --global mergetool.diffuse3.cmd '$HOME/.dotfiles/bin/gitdiffuse3merge.sh $BASE $LOCAL $REMOTE $MERGED'

