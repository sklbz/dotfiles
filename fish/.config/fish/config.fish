if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x STARSHIP_CONFIG ~/.config/starship/default.toml

set -x EDITOR nvim

source ~/.config/fish/alias.fish

set PATH $PATH ~/.cargo/bin

starship init fish | source
