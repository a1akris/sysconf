# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:$HOME/bin

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  export BEMENU_DISPLAY=wayland
  sway
fi

alias ls='ls --color=auto'


PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export HISTCONTROL=ignoreboth:erasedups

starship --version &>/dev/null
if [ $? -eq 0 ]; then
    eval -- "$(/usr/bin/starship init bash --print-full-init)"
fi

# Added by Radicle.
export PATH="$PATH:/home/sanshi/.radicle/bin"
