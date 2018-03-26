function git_parent_branch {
	git show-branch | sed "s/].*//" | grep "\*" | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -n1 | sed "s/^.*\[//"
}

function git_clean {
    git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}
