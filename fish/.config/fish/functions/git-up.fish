function git-up --wraps='git-add && git-commit && git-sync' --description 'alias git-up=git-commit && git-sync'
  git-commit $argv && git-sync
end
