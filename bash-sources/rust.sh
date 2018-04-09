#!/bin/bash

if [ ! -d $(readlink -f ~/.cargo) ] ; then
    echo ""
    echo "---------------------------------"
    echo "Rust is not installed, installing"
    echo "---------------------------------"
    echo ""
    curl https://sh.rustup.rs -sSf | sh
fi

source $HOME/.cargo/env
