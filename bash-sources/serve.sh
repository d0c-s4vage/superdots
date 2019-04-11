
function g__srv_nginx {
    tmpdir=$(tempfile)
    rm "$tmpdir" && mkdir -p "$tmpdir"
    (
        cd "$tmpdir"
        cat <<-EOF > default.conf
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        autoindex on;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
EOF
    )
    CMD=(
        sudo docker run
            --rm
            -p 0.0.0.0:9090:80
            -v "$tmpdir":/etc/nginx/conf.d/
            -v $(pwd):/usr/share/nginx/html:ro
            nginx
    )
    "${CMD[@]}"
    rm -rf "$tmpdir"
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
