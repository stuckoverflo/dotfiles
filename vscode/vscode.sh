#!/usr/bin/env zsh

CONFIG_DIR="Library/Application Support/Code/User"

E='[exists]'
I='[installed]'

install () {
  if [ -e "$HOME/$2" ]; then
    echo $2 $E
    read -q "CONFIRM?Replace existing? (y/n) "
    echo
  fi
  if ([ ! -e "$HOME/$2" ] || [[ $CONFIRM =~ ^[Yy]$ ]]); then
    rm -r $HOME/$2 > /dev/null 2>&1
    ln -s `pwd`/$1 $HOME/$2 && echo $2 $I
  fi
  echo
}

install $thisDir/settings.json "$CONFIG_DIR/settings.json"

thisDir=${0%/*}
while read p; do
    code --install-extension $p
done <$thisDir/extensions.txt
