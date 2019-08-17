#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
THIS_PROG="$0"


# defines bash completion utility functions
function meta-add_completion {
    fn_name="$1"
    completion_src="$2"
    completion_fn="$3"

    complete_line="complete -F ${completion_fn} ${fn_name}"

    if [ ! -f ~/.bash_completion ] || ! grep "${complete_line}" ~/.bash_completion >/dev/null 2>&1 ; then
        echo -e ". '$DIR/${completion_src}' ; ${complete_line}" >> ~/.bash_completion
    fi
}
