DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export YOUR_MOM="$DIR"


SOURCE_DIRS=(
    "$DIR"/bash-sources/
    ~/.bash-sources/
)


# source all bash source files
for source_dir in "${SOURCE_DIRS[@]}" ; do
    # skip it if it doesn't exist
    if [ ! -d "$source_dir" ] ; then
        continue
    fi

    for file in "$source_dir"/*.sh ; do
        if [ ! -z "$YOUR_MOM_DEBUG" ] ; then
            echo "Sourcing $file"
        fi
        . "$file"
    done
done


# add bash-scripts to PATH
export PATH="$PATH:$DIR/bash-scripts"
export EDITOR=vim
