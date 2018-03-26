
function docker_netstat {
    image_name="$1"
    shift
    pid=$(docker inspect -f '{{.State.Pid}}' "$image_name")
    sudo nsenter -t "$pid" -n netstat "$@"
}

function docker_cmd {
    image_name="$1"
    shift
    pid=$(docker inspect -f '{{.State.Pid}}' "$image_name")
    sudo nsenter -t "$pid" -n "$@"
}

function docker_ip {
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1
}
