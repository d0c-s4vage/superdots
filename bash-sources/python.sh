export WORKON_HOME=~/.venvs

function venv {
	dest="./venv"
	if [ $# -eq 1 ] ; then
		dest="$1"
	fi

	if [[ ! -d "$dest" ]] ; then
		echo "creating virtual environment at $dest"
		virtualenv "$dest"
	fi

	source "$dest/bin/activate"
}
