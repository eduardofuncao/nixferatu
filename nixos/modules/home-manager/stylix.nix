{ pkgs, lib, stylix, ... }:
{
  stylix.enable = true;
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-gorgoroth.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/vesper.yaml";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/mocha.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/terracotta.yaml";
  stylix.image = ./bg.jpg;
  stylix.polarity = "dark";

  stylix.targets = {
    fish.enable = false;
    kitty.enable = true;
    btop.enable = true;
    neovim.enable = false;
    tmux.enable = true;
    waybar.enable = true;
    gtk.enable = true;
    zen-browser = {
      enable = false;
      profileNames = [ "default" ];
    };
  };

  stylix.cursor = {
    package = pkgs.volantes-cursors;
    name = "volantes_cursors";
    size = 24;
  };

  stylix.fonts = {
    serif = {
      package = pkgs.poppins;
      name = "Poppins";
    };
    sansSerif = {
      package = pkgs.poppins;
      name = "Poppins";
    };
    monospace = {
      package = pkgs.maple-mono.truetype;
      name = "Maple Mono";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
} 
