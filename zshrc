[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export DIRENV_BASH=/bin/bash
eval "$(direnv hook zsh)"
alias da='direnv allow'

source "$HOME/.slimzsh/slim.zsh"

