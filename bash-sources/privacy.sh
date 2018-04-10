
PROXY_HOST=""
PROXY_SSH_KEY=""
PROXY_PORT=7070
PROXY_BROWSER="chromium-browser"

function ssh_setup {
    ssh-add -l | grep -q $(realpath "$PROXY_SSH_KEY") || ssh-add "$PROXY_SSH_KEY"

    ssh -D "$PROXY_PORT" -N -C -q -N "$PROXY_HOST" &
    sshpid=$!

    echo "waiting for proxy to spin up before launching browser"
    sleep 5
}

function ssh_teardown {
    kill $sshpid
}

function error_check {
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
        echo "PROXY_PORT must be set"
        error=true
    fi
}

function pcurl {
    error_check
    if [ "$error" = true ] ; then
        return
    fi

    curl --proxy "socks5://127.0.0.1:$PROXY_PORT" "$@"
}


function browse {
    setup_urls=(
        https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm
        https://chrome.google.com/webstore/detail/https-everywhere/gcbommkclmclpchllfjekcdonpmejbdp
        https://chrome.google.com/webstore/detail/duckduckgo-privacy-essent/bkdgflcldnnnapblkhphbgpggdiikppg
    )

    error_check
    if [ "$error" = true ] ; then
        return
    fi

    ssh_setup

    proxy_dir="/tmp/chrome_browse"
    if [ -d "$proxy_dir" ] ; then
        rm -rf "$proxy_dir"
    fi
    CMD=(
        $PROXY_BROWSER
            --no-first-run
            --no-default-browser-check
            --user-data-dir="$proxy_dir"
            --proxy-server=socks5://127.0.0.1:"$PROXY_PORT"
            --host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE 127.0.0.1"
            "${setup_urls[@]}"
            $@
    )
    "${CMD[@]}"

    rm -rf "$proxy_dir"

    ssh_teardown
}
