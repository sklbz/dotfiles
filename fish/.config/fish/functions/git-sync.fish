function git-sync --wraps='git push && git pull' --description 'alias git-sync=git push && git pull'
  git push && git pull $argv
        
end
