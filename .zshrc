export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export VISUAL=nvim
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

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.dotfiles/shell/aliases
source ~/.dotfiles/shell/utils

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

alias srcprof="source ~/.zshrc"

# gnu
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
alias readlink=greadlink

# python
alias python=python3
alias pip=pip3

#export PATH="/home/flo/.pyenv/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

export PATH="/home/flo/.local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source $HOME/.cargo/env
source $HOME/.dotfiles/zsh/.zshrc.custom
