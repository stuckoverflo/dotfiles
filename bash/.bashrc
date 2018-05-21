export LANG=en_IN.UTF-8

[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh
[ -f ~/.fzf.bash  ] && source ~/.fzf.bash

thisDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# source $thisDirectory/gruvbox_256palette.sh
# eval "$(dircolors $thisDirectory/.dircolors)"

source $thisDirectory/aliases.sh
source $thisDirectory/prompt.sh
