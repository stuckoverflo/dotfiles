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

#git
alias gr='cd $(git rev-parse --show-toplevel)'
alias wt='switch_to_worktree'
alias wtm='cd "$(git worktree list | grep "\[main\]" | awk "{print \$1}")"'

#terraform
alias tf=terraform

# todo.txt
alias t='todo.sh -d ~/.todo.cfg'
alias ta='t add'
alias tl='t list'
alias td='t do'
alias tp='t pri'

# TTDL (better for due dates and sorting)
alias tt='ttdl --todo-file "$HOME/Documents/notes/work/todo.txt"'
alias tts='tt list --sort due'
alias ttd='tt list --sort=priority --due=today'

# Open URL from a task line
todo-open() {
  local url=$(todo.sh -d ~/.todo.cfg list "$1" | grep -oE 'https?://[^ ]+' | head -1)
  if [ -n "$url" ]; then
    open "$url"
  else
    echo "No URL found in task $1"
  fi
}

# Archive completed items
todo-clean() {
  todo.sh -d ~/.todo.cfg archive
  echo "Archived completed items to done.txt"
}
