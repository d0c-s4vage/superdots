#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
THIS_PROG="$0"

meta-add_completion \
    fn_new \
    meta_completion \
    _fn_file_completion
function fn_new {
    if [ $# -ne 1 ] ; then
        echo "USAGE: new_fn FN_FILE_NAME"
        return 1
    fi

    fn="$1"
    fnpath="${SUPERDOTS}/bash-sources/${fn}.sh"

    if [ -e "${fnpath}" ] ; then
        start_cmd="Go\\<cr>"
        snippet="new_bash_fn_plain\\<c-l>"
    else
        start_cmd="0i"
        snippet="new_bash_fn\\<c-l>\\<c-l>\\<c-j>"
    fi

    vim \
        -s <(echo -e ':execute "normal '${start_cmd}${snippet}'"') \
        "$fnpath"
    
    if [ -e "$fnpath" ] ; then
        source "$fnpath"
        echo "new function ready to go!"
    else
        echo "did not source unsaved function file"
    fi
}

meta-add_completion \
    fn_edit \
    meta_completion \
    _fn_file_completion
function fn_edit {
    if [ $# -ne 1 ] ; then
        echo "USAGE: edit_fn FN_FILE_NAME"
        return 1
    fi

    fn="$1"
    fnpath="${SUPERDOTS}/bash-sources/${fn}.sh"

    if [ ! -e "${fnpath}" ] ; then
        new_fn
        return $?
    fi

    vim "${fnpath}"

    if [ -f "${fnpath}" ] ; then
        source "${fnpath}"
        echo "new changes are ready for use"
    fi
}

meta-add_completion \
    fn \
    meta_completion \
    _fn_fn_completion
function fn {
    if [ $# -lt 1 ] ; then
        echo "USAGE: fn FN_NAME"
        return 1
    fi

    fn="$1"
    shift
    $fn "$@"
}
