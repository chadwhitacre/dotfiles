# Oh My Zsh
# =========

plugins=(git)
HIST_STAMPS="yyyy-mm-dd"
ZSH_THEME="chadwhitacre"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
export ZSH="/Users/chadwhitacre/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
unsetopt AUTO_CD


# PATH
# ====

export PATH="$HOME/bin:./bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"


# Other Environment Variables
# ===========================

export EDITOR=vim
export PAGER=less
export BLOCKSIZE=K
export LANG="en_US.UTF-8"
export PYTHONDONTWRITEBYTECODE=true
export LSCOLORS=gxfxcxdxbxegedabagacad
export PYTEST_ADDOPTS="--tb=native --capture=no"
export LESS='--RAW-CONTROL-CHARS --chop-long-lines --LONG-PROMPT'


# Navigation
# ==========

alias c='cd'
alias p='pwd'
alias l='clear && p && ls -FGl'
alias u='c .. && l'
alias w='c ~/workbench/ && l'


# Grab Bag 
# ========

center() {
    columns="$(tput cols)"
    while IFS= read -r line; do
        printf "%*s\n" $(( (${#line} + columns) / 2)) "$line"
        #printf "%*s\n" "10" "$line"
    done < "${1:-/dev/stdin}"
}

alias sc="screen -D -RR -U"
alias pbtrim="pbpaste | sed -e 's/ *$//' | pbcopy"
alias fetch="curl --remote-name --remote-header-name"
alias h="python3 -m http.server -b 0.0.0.0 ${1:-4000}"
alias grip="grip --user chadwhitacre --pass $(cat ~/.grip/token) -b"
alias ag="ag -i --pager='less -R' -S"
alias remove-screenshots="rm -f ~/Desktop/Screenshot\ *.png ~/Desktop/framed"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
function cal { clear; echo; echo; echo; /usr/bin/cal ${1:-$(date +%Y)}; echo; echo; echo }
alias ubuntu="dr -v\"$(pwd):/portal\" -w/portal ubuntu:latest bash"
function heic-to-webp {
  magick mogrify -monitor -format webp $(find . -maxdepth 1 -iname \*.heic)
  rm $(find . -maxdepth 1 -iname \*.heic)
}


# Git
# ===

alias ci="git commit"
alias co="git checkout"
alias gb="git branch"
alias gbb="git bisect bad"
alias gbg="git bisect good"
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
alias gsa="git stash"
alias gsp="git stash pop"
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


# Docker
# ======

alias dim="docker image"
alias dil="docker image ls -a"
alias dcn="docker container"
alias dcl="docker container ls -a"
alias dcm="docker-compose"
alias dsp="yes | docker system prune"

# build an image                dib <path>
dib() { [ -n "$1" ] && docker image build -t "$(basename $(realpath $1))" "$1"; }

# create a new container        dnew (-it) (--entrypoint) <image:sha|name> (<command>)
alias dnew="docker run --rm"            

# quick docker run              dr (--entrypoint) <image:sha|name> (<command>)
alias dr="docker run --rm -it"

# run in an existing container  drun <running container:sha> <command>
alias drun="docker container exec -it"

# shell into a new container    dsh <running container:sha>
dsh() { docker container exec -it "$1" /bin/sh; }

# bring up a service            dcu <service:name>
alias dcu="docker-compose up --build"
alias dcr="docker-compose run --rm"


# Random String (Password) Helpers
# ================================

rnd() {
  N="${1:-32}"
  od -vAn -N"$N" -tx1 < /dev/urandom | tr -d '[:space:]' | head -c "$N"
  echo
}

rp() {
  rnd "$1" | pbcopy
}


# man
# ===
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


# Vim
# ===
# http://sealence.x10hosting.com/wordpress/?p=28
# Ctrl-S is usually stop (tty control flow), but we want Vim to see it.
# Ctrl-Q is start, for the record.

stty stop ^-


# Shell Hooks
# ===========

source ~/.fzf.zsh
eval "$(direnv hook zsh)"


# Local Customizations
# ====================

source ~/.zshrc.local
