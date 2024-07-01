# oh my zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export VISUAL=nvim
export EDITOR=$VISUAL

# PATH
export PATH="/home/flo/.local/bin:$PATH"
export PATH="/home/flo/.dotfiles/scripts/:$PATH"
export PATH="/home/flo/go/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"

# aliases
alias python=python3
alias pip=pip3
alias srcprof="source ~/.zshrc"
source ~/.dotfiles/scripts/aliases.sh
source ~/.dotfiles/scripts/utils.sh

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
eval "$(fzf --zsh)"

export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
bindkey '^P' fzf-file-widget

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}

zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept
export FZF_DEFAULT_COMMAND='fd --type f'

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

source ~/fzf-git.sh/fzf-git.sh

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# gnu-getopt
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
alias readlink=greadlink

export PATH="/home/flo/.local/bin:$PATH"

# zoxide
eval "$(zoxide init zsh --cmd cd)"

# eza
alias ls="eza --long --icons=always --color=always --no-permissions --group-directories-first"

# bat
export BAT_THEME=tokyonight_storm

# starship prompt
eval "$(starship init zsh)"

if uname -r | grep -q "WSL"; then
  source $HOME/.cargo/env
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export PATH="/home/linuxbrew/.linuxbrew/opt/node@20/bin:$PATH"
fi
