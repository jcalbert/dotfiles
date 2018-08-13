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

antigen theme sorin



# The following lines were added by compinstall
zstyle :compinstall filename '/home/jcalbert/.zshrc'

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

#default go path
export GOPATH=$HOME/go

#must be the last command
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

. ~/miniconda2/etc/profile.d/conda.sh
