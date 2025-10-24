set -gx PATH $HOME/.config/scripts $HOME/go/bin $PATH
set -x fish_greeting ""
set -x EDITOR nvim
set -x PAGER less

fish_vi_key_bindings

zoxide init fish | source
starship init fish | source
