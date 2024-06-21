#!/usr/bin/env zsh

E='\033[1;30m[exists]'
I='\033[1;32m[installed]'
R='\033[0m'

install () {
  if [ -e "$HOME/$2" ]; then
    echo $2 $E$R
    read -q "CONFIRM?Replace existing? (y/n) "
    echo
  fi
  if ([ ! -e "$HOME/$2" ] || [[ $CONFIRM =~ ^[Yy]$ ]]); then
    rm -r $HOME/$2 > /dev/null 2>&1
    ln -sf `pwd`/$1 $HOME/$2 && echo $2 $I$R
  fi
  echo
}

install .bashrc .bashrc
install .dircolors .dircolors
install .gitignore_global .gitignore_global
install .inputrc .inputrc
install .tmux.conf .tmux.conf
install .tmux-cht-languages .tmux-cht-languages
install .tmux-cht-commands .tmux-cht-commands
install .vimrc .vimrc
install .zshrc .zshrc

mkdir -p $HOME/.config/nvim
install .config/nvim .config/nvim

mkdir -p $HOME/.config/direnv
install .config/direnv/direnvrc .config/direnv/direnvrc

