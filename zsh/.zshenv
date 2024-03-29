#!/bin/sh
# Read on every new shell
# echo "Sourcing zshenv"
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# keeping all these as defaults, but xdg_paths below should override them
export XDG_CONFIG_HOME="$HOME/.local/src/user/config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"

export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_DOWNLOAD_DIR="$HOME/dl"
export XDG_MUSIC_DIR="$HOME/art/music"
export XDG_PICTURES_DIR="$HOME/art/pics"
export XDG_PUBLICSHARE_DIR="$HOME/public"
export XDG_TEMPLATES_DIR="$HOME/art/templates"
export XDG_VIDEOS_DIR="$HOME/art/vids"

# resourcing just in case
# source ${XDG_CONFIG_HOME}/xdg_environment
# alias nvim='unexport VIMINIT nvim '

source ${XDG_CONFIG_HOME}/aliases
source ${XDG_CONFIG_HOME}/environment

# export LANG='en_US.UTF-8'
export LANG='en_US.UTF-8'

export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/radeon_icd.i686.json

