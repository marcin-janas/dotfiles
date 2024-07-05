# set
set -o noclobber
set -o notify
set -o vi

# shopt
shopt -s cdspell
shopt -s checkwinsize
shopt -s histappend
shopt -s no_empty_cmd_completion
shopt -s autocd
shopt -s checkhash
shopt -s cmdhist
shopt -s extglob
shopt -s globstar
shopt -s nocaseglob
shopt -s dirspell direxpand

# export
export_ps1() {
    PS1="\n\n\n\u@\h:\w ($(git rev-parse --abbrev-ref HEAD 2>/dev/null||echo none))\n"
}

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PROMPT_COMMAND='history -n; history -a; export_ps1'
export EDITOR=nvim
export GOPATH=$HOME
export LC_ALL=en_US.UTF-8
export HISTFILESIZE=
export HISTSIZE=
export HISTCONTROL=ignoredups
# export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT="%Y-%m-%d_%H:%M:%S_%a  "
export HISTIGNORE="&:bg:fg:ll:h"
export IGNOREEOF=1 # ctrl+d must pressed twice to exit Bash
export GITHUB_TOKEN=$(git config  --get github.token)
# gdk
export GDK_DPI_SCALE=1.4
export GDK_SCALE=1.4

# nvim
alias vi='nvim -O'
alias v='vi $(fzf)'

# ls
alias l='ls -FGla'
alias ls='ls -G --color=auto'
alias ll='ls -al'                              # long list format
alias lk='ls -lk'                              # --block-size=1K
alias lt='ls -ltr'                             # sort by date (mtime)
alias lc='ls -ltcr'                            # sort by and show change time
alias la='ls -ltur'                            # sort by and show access time
alias lx='ls -lXB'                             # sort by extension
alias lz='ls -lSr'                             # sort by size
alias ld='ls -d */'                            # ls only Dirs
alias l.='ls -dAFh .[^.]*'                     # ls only Dotfiles
alias lst='ls -hFtal | grep $(date +%Y-%m-%d)' # ls Today

# git
git-checkout() {
  if [[ "$1" != "" ]]
  then
    git checkout $@
  else
    git checkout $(git branch|fzf)
  fi
}

git-reset() {
  git reset --$1 HEAD~$2
}

alias tmux='TERM=xterm-256color tmux'
alias gcd='cd $(find ~/src  -type f -name config|sed "s/.git\/config//"|fzf)'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -s -m'
alias gco=git-checkout
alias gcom='git checkout master'
alias gcop='git checkout production'
alias gcob='git checkout -b'
alias gd='git diff'
alias gds='git diff --numstat --shortstat HEAD'
alias gdh='git diff HEAD'
alias gl='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias glf='git log --follow --'
alias gp='git pull'
alias gpfm='git push-for-master'
alias gpusho='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpullo='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias grsoft='git-reset soft'
alias gs='git status'
alias gsh='git show'
alias gsno='git show --name-only'
alias gbdm='git checkout master && git branch --merged |grep -vE "master|\*"|xargs -n 1 git branch -d'

# kubectl
alias k='kubectl'
alias kl='k logs -f'
# delete
alias kdel='k delete'
alias kdelp='kdel pod'
alias kdelc='kdel cronjob'
alias kdels='kdel services'
alias kdeld='kdel deployment'
alias kdelns='kdel namespace'
alias kdele='kdel endpoints'
alias kdelsf='kdel statefulset'
# get
alias kg='k get'
alias kge='kg events'
alias kgea='kg events --all-namespaces'
alias kgp='kg pods'
alias kgc='kg cronjob'
alias kgs='kg services'
alias kgd='kg deployments'
alias kgns='kg namespaces'
alias kgn='kg nodes'
alias kge='kg endpoints'
alias kgsf='kg statefulset'
# describe
alias kd='k describe'
alias kdp='kd pod'
alias kdc='kd cronjob'
alias kds='kd services'
alias kdd='kd deployments'
alias kdns='kd namespaces'
alias kdn='kd node'
alias kde='kd endpoints'
alias kdsf='kd statefulset'

alias kctx='kubectx $(kubectx|fzf)'
alias kns='kubens $(kubens|fzf)'
alias krr='kubectl rollout restart statefulset'
alias kbash='kubectl run -it --image bash --restart Never --rm shell'

function ksh() {
    echo $1
    kubectl exec -it $(echo $@) -- sh
}

alias pghero="docker run -ti -e DATABASE_URL=postgres://${DB_USER}:${DB_PASS}@10.0.2.1:5432/${DB_USER} -p 8080:8080 ankane/pghero"

# cd alias
alias ..='cd ..'
alias cdf='cd $(find . -not -path "*/.git/*" -type d|fzf)'
alias cdm='cd ~/src/github.com/marcin-janas'
alias cdg='cd ~/src/github.com/;cd $(find . -type d -not -path "*/.git/*"|fzf)'

# other alias
alias fzf='fzf --ansi --no-bold --tabstop=4 --color=light'
alias of='FILE=$(find . -type f -not -path "*/.git/*"|fzf); xdg-open $FILE >|/dev/null; echo $FILE'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias df='df -kTh'
alias ln='ln -i -n'
alias psg='ps -ef | grep $1'
alias h='history | grep $1'
alias j='jobs'
alias ff='find . ! -path "*.git/*" -type f -iname '
alias fd='find . ! -path "*.git/*" -type d -iname '
alias f='find . ! -path "*.git/*" -iname '
alias less='less -R --tabs=4'
alias more='less'
alias mkdir='mkdir -p -v'
alias wget='wget -c'
alias grep='grep --color'
alias g='grep -IErni --exclude-dir .git '
alias s='sudo su -'
alias x='startx'
# alias recd='recordmydesktop --no-cursor --windowid $(xwininfo -display :0 | grep "id: 0x" | grep -Eo "0x[a-z0-9]+")'
# alias rdpw="rdesktop -u $USER -d $(dnsdomainname) 106.120.111.36 -g 1674x1028 -r disk:share=/home/$USER/share -a 24 -K"
alias rl="source ~/.bashrc; echo Reload ~/.bashrc"
alias brc="vi ~/.bashrc; source ~/.bashrc; echo Reload ~/.bashrc"
alias vrc="vi ~/.vimrc"
# alias cds="cd ~/src/; cd $(fzf $(ls .))"
alias am='alsamixer  -g'
# alias which='type -a'

# docker
alias d='docker'
alias dl='d container ls --all'
alias dp='d ps -a'
alias dk='d kill'
alias de='d exec -it'
alias dil='d image list'
alias dsh='d run -v ~/tmp:/tmp -it --entrypoint sh --user root'

# timeout 5 bash -c 'cat < /dev/null > /dev/tcp/HOST/PORT'; echo $?
