
PROXY_HOST=""
PROXY_SSH_KEY=""
PROXY_PORT=7070
function browse {
    error=false
    if [ -z "$PROXY_HOST" ] ; then
        echo "PROXY_HOST must be set"
        error=true
    fi
    if [ -z "$PROXY_SSH_KEY" ] ; then
        echo "PROXY_SSH_KEY must be set"
        error=true
    fi
    if [ -z "$PROXY_PORT" ] ; then
        echo "PROXY_SSH_KEY must be set"
        error=true
    fi
    if [ "$error" = true ] ; then
        return
    fi

    ssh-add -l | grep -q $(realpath "$PROXY_SSH_KEY") || ssh-add "$PROXY_SSH_KEY"

    ssh -D "$PROXY_PORT" -N -C -q -N "$PROXY_HOST" &
    sshpid=$!

    proxy_dir="/tmp/chrome_browse"
    if [ -d "$proxy_dir" ] ; then
        rm -rf "$proxy_dir"
    fi
    CMD=(
        google-chrome
            --no-first-run
            --no-default-browser-check
            --user-data-dir="$proxy_dir"
            --proxy-server=socks5://127.0.0.1:"$PROXY_PORT"
            --host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE 127.0.0.1"
            $@
    )
    "${CMD[@]}"

    rm -rf "$proxy_dir"
    kill $sshpid
}
