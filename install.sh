#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
THIS_PROG="$0"

set -e

function source_vimrc {
    echo -e "source ${DIR}/.vimrc" >> "${HOME}"/.vimrc
    mkdir -p "${HOME}"/.vim/autoload
}

function source_bashrc {
    echo -e "source ${DIR}/.bashrc" >> "${HOME}"/.bashrc
}

function source_tmuxconf {
    echo -e "source ${DIR}/.tmux.conf" >> "${HOME}"/.tmux.conf
}

function source_screenrc {
    echo -e "source ${DIR}/.screenrc" >> "${HOME}"/.screenrc
}

function setup_usr_path {
    mkdir -p ${HOME}/usr/{lib,bin}
}

function setup_ws_dirs {
    mkdir -p ${HOME}/ws/{docs,meetings,src,dev,rd}
}

function setup_ssh_dir {
    mkdir -p ${HOME}/.ssh
    touch ${HOME}/.ssh/config
}

source_vimrc
source_bashrc
source_screenrc
source_tmuxconf
setup_usr_path
setup_ws_dirs
setup_ssh_dir
