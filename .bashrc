source ~/.dotfiles/shell/aliases.sh
source ~/.dotfiles/shell/utils.sh

source ~/.dotfiles/bash/prompt

source ~/.secrets

export LC_ALL=C
source ~/.dotfiles/bash/git-completion.bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# direnv
eval "$(direnv hook bash)"
alias da='direnv allow'

# FZF
[ -f ~/.fzf.bash  ] && source ~/.fzf.bash

# fasd
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

alias srcprof="source ~/.bashrc"

. "$HOME/.cargo/env"
