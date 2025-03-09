if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x STARSHIP_CONFIG ~/.config/starship/default.toml

source ~/.config/fish/alias.fish

starship init fish | source
