#!/bin/bash


function work {
    session_name="$1"

    matching_sessions=$(tmux ls | awk '{print $1}' | sed 's/://g' | grep "$session_name")
    if [ -z "$matching_sessions" ] ; then
        if [ -z "$TMUX" ] ; then
            tmux new -s "$session_name" -c "$(pwd)"
        else
            tmux detach -E 'tmux new -s "'$session_name'" -c "'$(pwd)'"'
        fi
    else
        unattached_session=$(tmux ls | grep "$session_name" | grep -v "attached" | awk '{print $1}' | sed 's/://g' | head -n 1)
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
    fi
}
