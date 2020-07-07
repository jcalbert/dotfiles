#use antigen
ANTIGEN_PATH=~/.dotfiles
source $ANTIGEN_PATH/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle mercurial
antigen bundle pip
antigen bundle command-not-found
antigen bundle z
antigen bundle colored-man-pages
#antigen bundle conda

#antigen theme nicoulaj
antigen bundle $HOME/.dotfiles/antigen_config/custom/oh-my-zsh/themes
antigen bundle $HOME/.dotfiles/antigen_config/custom/oh-my-zsh/themes repo-hash.zsh-theme --no-local-clone
#antigen theme $HOME/.dotfiles/antigen_config/custom/oh-my-zsh/themes repo-hash.zsh-theme


# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
unsetopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install

#one-work cheatsheets
cheat () {curl cheat.sh/$1}

#display qr data in the console
qrcat () {qrencode -t utf8 $1}
qrpaste () {xclip -o | qrencode -t utf8 $1}

#default go path
export GOPATH=$HOME/go

#generic syntax highlighting
alias pcat='pygmentize -f 256 -O style=native -g'

#gentle reminders
##don't use ifconfig
IFCONFIG_PATH=$(which ifconfig)
function ifconfig () {
    echo "Consider using $(tput smso)ip addr$(tput rmso) instead of ifconfig."
    sleep 2
    $IFCONFIG_PATH $@
}

##use dtrx
TAR_PATH=$(which tar)
fucntion tar () {
    while getopts ":x" opt; do
        case $opt in
            x)
                echo "Consider using $(tput smso)dtrx$(tput rmso) instead of tar -x."
                sleep 2
        esac
    done
    $TAR_PATH $@
}

#must be the last command
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# . ~/miniconda2/etc/profile.d/conda.sh
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/joe/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/joe/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/joe/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/joe/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#AWS for covid stuff
autoload bashcompinit && bashcompinit
complete -C '/home/joe/apps/aws-cli/v2/current/bin/aws_completer' aws
