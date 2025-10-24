{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    prefix = "C-a";
    mouse = true;
    baseIndex = 1;
    extraConfig = ''
      # Unbind and rebind r to reload config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # Enable mouse
      set -g mouse on
      set -g base-index 1

      # Vim-like keys for panes
      setw -g mode-keys vi
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # Custom session script binding
      bind f run-shell "tmux neww ~/.config/scripts/tmux-session.sh"

      # Allow passthrough for terminals like kitty/wezterm
      set -gq allow-passthrough on

      # Visual activity off
      set -g visual-activity off

      # --- Status Bar ---
      set -g status on
      set -g status-position top
      set -g status-interval 2
      set -g status-justify centre
      
      # Override Stylix backgrounds to be transparent (keep foreground colors)
      set -g status-style bg=default
      set-window-option -g window-status-style fg=default,bg=default
      set-window-option -g window-status-current-style fg=colour167,bg=default

      # --- Left: session name (color handled by Stylix) ---
      set -g status-left " #S "

      # --- Right: date and time (color handled by Stylix) ---
      set -g status-right " %Y-%m-%d %H:%M "

      # --- Active window style (color and style handled by Stylix) ---
      set -g window-status-current-format " • #I:#W "

      # --- Inactive window style (color and style handled by Stylix) ---
      set-window-option -g window-status-format " #I:#W "

      # --- Remove separators ---
      set -g status-left-length 20
      set -g status-right-length 60
      set -g status-left-style none
      set -g status-right-style none

      # --- Enable vi mode for copy mode ---
      set-window-option -g mode-keys vi
    '';
  };
}
