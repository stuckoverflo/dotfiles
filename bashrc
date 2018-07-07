source ~/.dotfiles/shell/aliases
source ~/.dotfiles/shell/prompt
source ~/.dotfiles/shell/utils

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# FZF
[ -f ~/.fzf.bash  ] && source ~/.fzf.bash

# direnv
eval "$(direnv hook bash)"
alias da='direnv allow'
