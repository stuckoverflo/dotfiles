source ~/.dotfiles/shell/aliases
source ~/.dotfiles/shell/utils

source ~/.secrets

# direnv
export DIRENV_BASH=/bin/bash
eval "$(direnv hook zsh)"
alias da='direnv allow'

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fasd
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

alias srcprof="source ~/.zshrc"

source "$HOME/.slimzsh/slim.zsh"

