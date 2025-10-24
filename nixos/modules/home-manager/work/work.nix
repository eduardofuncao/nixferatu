{ pkgs, lib, ... }:

let
  httptoolkit = pkgs.callPackage ./httptoolkit.nix {};
  web-agent = pkgs.callPackage ./web-agent.nix {};

in
{
  home.packages = with pkgs; [
    httptoolkit
    dbeaver-bin
    openfortivpn
    android-studio
    teams-for-linux

    steam-run
    web-agent
  ];

  # Also install the desktop file and icons separately for system integration
  xdg.desktopEntries.web-agent = {
    name = "Web Agent";
    exec = "${web-agent}/bin/web-agent";
    icon = "${web-agent}/usr/share/icons/hicolor/256x256/apps/web-agent.png";
    comment = "Web Agent application";
    categories = [ "Application" ];
  };
}
