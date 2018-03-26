
function g__srv_nginx {
    docker run --rm -p 0.0.0.0:8080:80 -v $(pwd):/usr/share/nginx/html:ro nginx
}

function g__previewmd {
	(
		sleep 0.5
		google-chrome http://localhost:8080/
	) &
    # https://github.com/joeyespo/grip
	grip --user-content $1 8080
}

function g__expandurl {
	wget -S --spider --no-check-certificate "$1" 2>&1 | grep ^Location
}
