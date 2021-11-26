#!/bin/sh

# ECOS
export ECOS_HOME="$HOME/.ecos"

#################################################
# PATH
#################################################

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$ECOS_HOME/bin"

#################################################
# SOURCE ECOS ENV
#################################################

source $ECOS_HOME/config/ecos.conf

#################################################
# EXPORT ENV VARS
#################################################

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# X11
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XAUTHORITY="$XDG_CACHE_HOME/xauthority"

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# CONSOLE DEFAULT
export TERMINAL="kitty"
export EDITOR="nvim"

# CLEAN HOME
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export LESSHISTFILE="-"

# MAVEN
export M2_HOME="$XDG_DATA_HOME/maven"

# NPM
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/node_modules"
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/config"
export NPM_CONFIG_CACHE="$HOME/.cache/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"

# JAVA
export JDK_HOME="/usr/lib/jvm/java-11-openjdk/"
export JAVA_HOME="$JDK_HOME"
export _JAVA_AWT_WM_NONREPARENTING=1

#################################################
# START X SERVER
#################################################

[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1 && exec startx "$XINITRC" >/dev/null 2>&1
