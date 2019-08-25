#!/usr/bin/env bash

PATH="$PATH:$HOME/.rbenv/bin"

if ! hash rbenv ; then
    echo "rbenv not found, installing"
    url="https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer"
    curl -fsSL "$url" | bash
fi

eval "$(rbenv init -)"
