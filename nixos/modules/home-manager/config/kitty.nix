{ pkgs, lib, stylix, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = lib.mkForce "0.9";
    };

    extraConfig = ''
      window_margin_width 10

      scrollback_lines 2000

      shell_integration enabled
    '';
  };
} 
