alias dc=cd
alias sl=ls
alias gerp=grep
alias grpe=grep

alias lsd="ls -la | grep "^d" && ls -la | grep -v "^d""
alias ll="ls -alh"
alias lll="ls -haltr"
alias lg="lll | grep -i"

alias lo="logout"
alias cls="clear"
alias wcl="wc -l"
alias dirsize="du -sh"
alias dirsize2="du -sh * | sort -n"

# python
alias p=python3
alias python=python3
alias python_makefile="curl -sL git.io/py_makefile > Makefile"

# git
alias gr='cd $(git rev-parse --show-toplevel)'

# nvim
alias vim=nvim
alias emacs=nvim

#obsidian
alias sb='cd notes'
