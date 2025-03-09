function git-commit --wraps='git commit -m' --description 'alias git-commit=git-add && git commit -m'
	set commit_msg $argv
	if test -z $commit_msg
		set commit_msg "update"
	end
  git-add && git commit -m $commit_msg
        
end
