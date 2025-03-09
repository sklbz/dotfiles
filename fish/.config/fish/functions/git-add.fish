function git-add --wraps='git add -A' --description 'alias git-add=git add -A'
  git add -A $argv
        
end
