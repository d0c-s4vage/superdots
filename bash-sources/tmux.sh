#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ ! -f ~/.bash_completion ] || ! grep "complete -F _work work" ~/.bash_completion >/dev/null 2>&1 ; then
    echo -e ". '$DIR/tmux_work_completion' ; complete -F _work work" >> ~/.bash_completion
fi

function work {
    session_name="$1"

    # exact match ONLY, now that we have tab-completion!
    matched_name=$(tmux ls | awk '{print $1}' | sed 's/://g' | grep '^'"$session_name"'$')

    if [ -z "$matched_name" ] ; then
        if [ -z "$TMUX" ] ; then
            tmux new -s "$session_name" -c "$(pwd)"
        else
            tmux detach -E 'tmux new -s "'$session_name'" -c "'$(pwd)'"'
        fi
        return
    fi

    unattached_session=$(tmux ls | grep -v "attached" | awk '{print $1}' | sed 's/://g' | grep "^${session_name}[-0-9]*"'$' |  head -n 1)
    if [ -z "$TMUX" ] ; then
        if [ -z "$unattached_session" ] ; then
            tmux new-session -t "$session_name" -c "$(pwd)"
        else
            tmux attach -t "$unattached_session"
        fi
    else
        if [ -z "$unattached_session" ] ; then
            tmux detach -E 'tmux new-session -t "'$session_name'" -c "'$(pwd)'"'
        else
            tmux switch -t "$unattached_session"
        fi
    fi
}
