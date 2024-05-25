export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL=vim
export EDITOR=$VISUAL

# zsh
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks

# direnv
export DIRENV_BASH=/bin/bash
eval "$(direnv hook zsh)"
alias da='direnv allow'

# cheat
export CHEATCOLORS=true
export DEFAULT_CHEAT_DIR="$HOME/.dotfiles/cheat/"
fpath=("~/.dotfiles/zsh/completions/" $fpath)

# slim ZSH
# source ~/.dotfiles/zsh/slimzsh/slim.zsh

# fasd
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.dotfiles/shell/aliases
source ~/.dotfiles/shell/utils

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

source ~/.secrets/.secrets
alias srcprof="source ~/.zshrc"

# gnu
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
alias readlink=greadlink

# python
alias python=python3
alias pip=pip3

[ -z "$SSH_AUTH_SOCK"  ] && eval "$(ssh-agent -s)"
ssh-add .ssh/github

#export PATH="/home/flo/.pyenv/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

export PATH="/home/flo/.local/bin:$PATH"
. "$HOME/.cargo/env"

