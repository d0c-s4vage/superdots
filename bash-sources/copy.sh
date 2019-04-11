#!/bin/sh


function copy_safe {
    cat | sed 's/james/dennisd/g' | copy
}

function safe {
    cat | sed 's/james/dennisd/g'
}
