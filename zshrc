export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL=vim
export EDITOR=$VISUAL

# direnv
export DIRENV_BASH=/bin/bash
eval "$(direnv hook zsh)"
alias da='direnv allow'

# cheat
export CHEATCOLORS=true
export DEFAULT_CHEAT_DIR="$HOME/.dotfiles/cheat/"
fpath=("~/.dotfiles/zsh/completions/" $fpath)

# slim ZSH
source ~/.dotfiles/zsh/slimzsh/slim.zsh

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

setopt hist_ignore_dups
source ~/.secrets/.secrets
alias srcprof="source ~/.zshrc"

# gnu
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
alias readlink=greadlink

# python
alias python=python3
alias pip=pip3
