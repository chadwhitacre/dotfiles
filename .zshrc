# Oh My Zsh
export ZSH="/Users/chadwhitacre/.oh-my-zsh"
ZSH_THEME="chadwhitacre"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git)
source $ZSH/oh-my-zsh.sh
unsetopt AUTO_CD

# Homebrew
export PATH="~/go/bin:/usr/local/opt/bin:/opt/homebrew/bin:$PATH"

# My stuff.
export PATH="$HOME/bin:$PATH"
export BLOCKSIZE=K
export EDITOR=vim
export PAGER=less
export LESS='--RAW-CONTROL-CHARS --chop-long-lines --LONG-PROMPT'
export LSCOLORS=gxfxcxdxbxegedabagacad
export LANG="en_US.UTF-8"

export PYTHONDONTWRITEBYTECODE=true
export PYTEST_ADDOPTS="--tb=native --capture=no"

rnd() {
  n=$1
  if [ -z "$n" ]; then
    n=32
  fi
  cat /dev/urandom | base64 | tr -cd 'a-f0-9' | head -c $n
  echo
}

rp() {
  rnd "$1" | pbcopy
}

# http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
# https://gist.github.com/cocoalabs/2fb7dc2199b0d4bf160364b8e557eb66

manc() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

# http://sealence.x10hosting.com/wordpress/?p=28
stty stop ^-
# Ctrl-S is usually stop (tty control flow), but we want vim to see it.
# Ctrl-Q is start, for the record.
eval "$(direnv hook zsh)"

# zsh
alias c='cd'
alias p='pwd'
alias l='clear && p && ls -FGl'
alias u='c .. && l'

# nav shortcuts
alias w='c ~/workbench/ && l'

# basics
alias sc="screen -D -RR -U"
alias pbtrim="pbpaste | sed -e 's/ *$//' | pbcopy"
alias h="python3 -m http.server -b 0.0.0.0 ${1:-7000}"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias fetch="curl --remote-name --remote-header-name"
alias grip="grip --user chadwhitacre --pass REPLACEME -b"

# git
alias ci="git commit"
alias co="git checkout"
alias gb="git branch"
alias gbm="git branch --merged"
alias gd="git diff" 
alias gdc="git diff --cached" 
alias gdh="git diff HEAD^"
alias gf="git fetch --prune" 
alias gg="git log --graph --decorate"
alias gm="git merge" 
alias gp="git push" 
alias gr="git rebase" 
alias grc="git rebase --continue" 
alias gs="git status --short"
alias qgs="gs"
alias gt="git tag"
alias gup="git fetch upstream && git rebase upstream/main && git push"
alias upages="git fetch upstream && git rebase upstream/gh-pages && git push"
alias cr='git codereview'  # for Go: https://golang.org/doc/contribute.html#git-config

gpn() {
  `gp 2>&1 | tail -n2`
}

bl() {
  git add .
  ci -nam blip
  gr -i master
}

blm() {
  git add .
  ci -nam blip
  gr -i main
}


# https://botbot.me/freenode/gittip/msg/5681704/
# https://github.com/gnarf/.dotfiles/blob/master/.gitconfig#L24-L27
pr() { 
  git fetch -fu origin refs/pull/$1/head:pr/$1
  git checkout pr/$1
}
prc() {
  git for-each-ref refs/heads/pr/* --format='%(refname)' | \
    while read ref; do git branch -D ${ref#refs/heads/}; done
}
pru() { 
  git fetch -fu upstream refs/pull/$1/head:pr/$1
  git checkout pr/$1
}

# ag
alias ag="ag -i --pager='less -R' -S --ignore node_modules"

# docker
# ======

# basics
alias dim="docker image"
alias dil="docker image ls -a"
alias dcn="docker container"
alias dcl="docker container ls -a"
alias dcm="docker-compose"

# build an image                dib <path>
dib() { [ -n "$1" ] && docker image build -t "$(basename $(realpath $1))" "$1"; }

# create a new container        dnew (-it) (--entrypoint) <image:sha|name> (<command>)
alias dnew="docker run --rm"            

# run in an existing container  drun <running container:sha> <command>
alias drun="docker container exec -it"

# run a shell in a container    dsh <running container:sha>
dsh() { docker container exec -it "$1" /bin/sh; }

# bring up a service            dcu <service:name>
alias dcu="docker-compose up --build"
alias dcr="docker-compose run --rm"


# fzf
source ~/.fzf.zsh

alias ubuntu="docker run --rm -it -v\"$(pwd):/portal\" -w/portal ubuntu:latest bash"

# PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/flutter/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"

alias remove-screenshots="rm -f ~/Desktop/Screen\ Shot\ *.png"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
