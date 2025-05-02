# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set up Node Version Manager
source /usr/share/nvm/init-nvm.sh

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias yay='yay --color=auto'
alias nv='nvim'

# Git aliases
alias gitcommit='git add -A && git commit -m'
alias gitup='git add -A && git commit -m "update" && git push'
alias gitsync='git push && git push'

# Flutter path
export PATH="/usr/bin/flutter/bin:$PATH"

PS1='[\u@\h \W]\$ '

# if [ "$TERM_PROGRAM" = tmux ]; then
	# fastfetch
# else
	list=$(yay -Qu)

	if ! { [ -z "$list" ]; }; then
		yay
	fi

	# if [ -z "$NVIM" ]; then
		# tmux
	# fi
# fi

export STARSHIP_CONFIG=~/.config/starship/catppuccin-powerline.toml

fish

eval "$(starship init bash)"
. "$HOME/.cargo/env"
