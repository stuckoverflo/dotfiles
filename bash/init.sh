thisDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh
eval "$(dircolors $thisDirectory/.dircolors)"

source $thisDirectory/aliases.sh
source $thisDirectory/prompt.sh
