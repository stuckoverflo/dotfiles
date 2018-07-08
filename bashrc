source ~/.dotfiles/shell/aliases
source ~/.dotfiles/shell/utils

source ~/.dotfiles/bash/prompt

source ~/.secrets

export LC_ALL=C
source ~/.dotfiles/bash/git-completion.bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# FZF
[ -f ~/.fzf.bash  ] && source ~/.fzf.bash

# direnv
eval "$(direnv hook bash)"
alias da='direnv allow'
