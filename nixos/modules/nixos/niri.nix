{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fuzzel
    waybar
    wl-clipboard
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    kitty
    swaybg
    swayidle
    swaylock-effects
    xwayland-satellite

    grim
    slurp
    swappy

    firefox
    adw-gtk3
    gnome-themes-extra
    papirus-icon-theme
  ];

  programs.niri.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = { };

  systemd.user.services.mako = {
    enable = true;
    script = "${pkgs.mako}/bin/mako";
  };

  # systemd.user.services.waybar = {
  #   enable = true;
  #   script = "${pkgs.waybar}/bin/waybar";
  # };

  xdg.portal.config = {
    common = {
      default = [
        "gtk"
        "gnome"
      ];
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    maple-mono.truetype
    lato
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
