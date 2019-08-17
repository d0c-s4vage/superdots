#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
THIS_PROG="$0"


function new_fn {
    if [ $# -ne 1 ] ; then
        echo "USAGE: new_fn FN_FILE_NAME"
        return 1
    fi

    fn="$1"
    fnpath="${YOUR_MOM}/bash-sources/${fn}.sh"

    if [ -e "${fnpath}" ] ; then
        start_cmd="Go\\<cr>"
        snippet="new_bash_fn_plain"
    else
        start_cmd="0i"
        snippet="new_bash_fn\\<c-l>"
    fi

    vim \
        -s <(echo -e ':execute "normal '${start_cmd}${snippet}'\\<c-l>\\<c-j>"') \
        "$fnpath"
    
    if [ -e "$fnpath" ] ; then
        source "$fnpath"
        echo "new function ready to go!"
    else
        echo "did not source unsaved function file"
    fi
}

function edit_fn {
    if [ $# -ne 1 ] ; then
        echo "USAGE: edit_fn FN_FILE_NAME"
        return 1
    fi

    fn="$1"
    fnpath="${YOUR_MOM}/bash-sources/${fn}.sh"

    vim "${fnpath}"
}
