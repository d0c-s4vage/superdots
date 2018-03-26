# virtualenvwrapper
export WORKON_HOME=~/.venvs
wrapper=/usr/local/bin/virtualenvwrapper.sh
if [ -e "$wrapper" ] ; then
    . "$wrapper"
else
    echo "Virtualenvwrapper script does not exist at '$wrapper'"
    echo "Make sure you have installed virtualenvwrapper globally with"
    echo ""
    echo "    sudo pip install virtualenvwrapper"
fi

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
