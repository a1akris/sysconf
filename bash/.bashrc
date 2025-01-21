# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  export BEMENU_DISPLAY=wayland
  sway
fi

eval "$(fzf --bash)"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_setup_completion path dir tree

alias ls='ls --color=auto'

function vcd() {
    cd ~/v
    dst=$(fd --type d | fzf --query="$1" -1 --height 40%)
    cd "$dst"
}

PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export HISTCONTROL=ignoreboth:erasedups
export ZK_NOTEBOOK_DIR=~/v/Own/Lib/Notes

starship --version &>/dev/null
if [ $? -eq 0 ]; then
    eval -- "$(/usr/bin/starship init bash --print-full-init)"
fi

# Added by Radicle.
export PATH="$PATH:/home/sanshi/.radicle/bin"
