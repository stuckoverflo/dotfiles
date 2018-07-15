export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# direnv
export DIRENV_BASH=/bin/bash
eval "$(direnv hook zsh)"
alias da='direnv allow'

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

source ~/.secrets
alias srcprof="source ~/.zshrc"
