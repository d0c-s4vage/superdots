DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


# source all bash source files
for file in "$DIR"/bash-sources/*.sh ; do
    echo "SOURCING $file"
    . "$file"
done


# add bash-scripts to PATH
export PATH="$PATH:$DIR/bash-scripts"
