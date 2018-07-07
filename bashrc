source ~/.dotfiles/bash/aliases
source ~/.dotfiles/bash/prompt
source ~/.dotfiles/bash/utils

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# FZF
[ -f ~/.fzf.bash  ] && source ~/.fzf.bash

# direnv
eval "$(direnv hook bash)"
alias da='direnv allow'
