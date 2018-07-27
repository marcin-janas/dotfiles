# set
set -o noclobber
set -o notify
set -o vi

# shopt
shopt -s cdspell
shopt -s checkwinsize
shopt -s histappend
shopt -s no_empty_cmd_completion
shopt -s cdspell
shopt -s checkhash
shopt -s cmdhist
shopt -s extglob

# export
export PROMPT_COMMAND='history -a'
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTTIMEFORMAT="%Y-%m-%d_%H:%M:%S_%a  "
export HISTIGNORE="&:bg:fg:ll:h"
export IGNOREEOF=1 # ctrl+d must pressed twice to exit Bash

# function
export_ps1() {
    BLUE="\[\033[01;34m\]";
    CYAN="\[\033[1;36m\]";
    GREEN="\[\033[1;32m\]";
    CLEAR="\[\033[00m\]";
    VENV=$(basename $VIRTUAL_ENV 2>/dev/null)
    [ -z "$VENV" ] && export PS1="$GREEN\u$CLEAR@$CYAN\h$CLEAR:$BLUE\w$CLEAR$(__git_ps1)$CLEAR # " \
        || export PS1="($VENV) $GREEN\u$CLEAR@$CYAN\h$CLEAR:$BLUE\w$CLEAR$(__git_ps1)$CLEAR # "
}

vim_init_plugins() {
    PLUGINS=$(grep 'https://github.com/' ~/.vimrc|awk '{print $2}')
    OLDPWD=$(pwd)
    mkdir -p ~/.vim/pack/plugins/start
    cd ~/.vim/pack/plugins
    pwd
    git init .
    cd ~/.vim/pack/plugins/start
    git submodule init
    for PLUGIN in $PLUGINS
    do
        echo -e "\nAdd $PLUGIN..."
        git submodule add $PLUGIN
        git add .
        git commit -m "Add $PLUGIN"
    done
    cd $OLDPWD
}

vim_list_plugins() {
    OLDPWD=$(pwd)
    cd ~/.vim/pack/plugins/start
    ls|sort
    cd $OLDPWD
}

vim_update_plugins() {
    OLDPWD=$(pwd)
    echo -e "\nUpdate plugins..."
    cd ~/.vim/pack/plugins/start
    git submodule update --remote --merge
    cd $OLDPWD
}

vim_info_plugin() {
    local PLUGIN=$1
    less ~/.vim/pack/plugins/start/$PLUGIN/README.rst
}

vim_add_plugin() {
    local PLUGIN=$1
    OLDPWD=$(pwd)
    cd ~/.vim/pack/plugins/start
    pwd
    echo -e "\nAdd $PLUGIN..."
    sed -i "1i\" $PLUGIN" ~/.vimrc
    git submodule add $PLUGIN
    git add .
    git commit -m "Add $PLUGIN"
    cd $OLDPWD
}

vim_remove_plugin() {
    local PLUGIN=$1
    OLDPWD=$(pwd)
    cd ~/.vim/pack/plugins/start
    git submodule deinit -f $PLUGIN
    git rm -r -f $PLUGIN
    rm -Rf ~/.vim/pack/plugins/.git/modules/start/$PLUGIN
    LN=$(sed -n "/^\" https:\/\/github.com\/.*$PLUGIN/=" ~/.vimrc|head -n1)
    [ -z "$LN" ] && echo "Plugin not found in ~/.vimrc" || sed -i "$LN d" ~/.vimrc
    cd $OLDPWD
}

# prompt
GIT_PROMPT_FILE=$(ls /usr/lib/git-core/git-sh-prompt /usr/share/git/completion/git-prompt.sh 2>/dev/null|head -n1)
if [ -f $GIT_PROMPT_FILE ]; then
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_HIDE_IF_PWD_IGNORED=true
    GIT_PS1_SHOWCOLORHINTS=true
    source $GIT_PROMPT_FILE
    export PROMPT_COMMAND='history -a; export_ps1'
fi

# ls alias
alias ls='ls --color'
alias l='ls -FG'
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

# git alias
alias g='git'
alias ga='g add'
alias gb='g branch'
alias gc='g commit -s -m'
alias gd='g diff'
alias gdh='g diff HEAD'
alias go='g checkout'
alias gs='g status'
alias gl='g plog'
alias gpfm='g push-for-master'
alias gsno='g show --name-only'

# cd alias
alias ..='cd ..'
alias cdg='cd ~/src/github.com/marcin-janas/'

# other alias
alias vi='vim'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias df='df -kTh'
alias ln='ln -i -n'
alias psg='ps -ef | grep $1'
alias h='history | grep $1'
alias j='jobs'
alias less='less -R --tabs=4'
alias more='less'
alias mkdir='mkdir -p -v'
alias wget='wget -c'
alias grep='grep --color'
alias s='sudo su -'
alias x='startx'
alias recd='recordmydesktop --no-cursor --windowid $(xwininfo -display :0 | grep "id: 0x" | grep -Eo "0x[a-z0-9]+")'
alias rdpw="rdesktop -u $USER -d $(dnsdomainname) 106.120.111.36 -g 1674x1028 -r disk:share=/home/$USER/share -a 24 -K"
alias rl="source /home/$USER/.bashrc; echo Reload ~/.bashrc"
alias cds="cd /home/$USER/src/"
alias am='alsamixer  -g'
# alias which='type -a'

# docker alias
alias d='docker'
alias dl='d container ls --all'
alias dp='d ps -a'
alias dk='d kill'
alias de='d exec -it'
