{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.kanata ];
  
  systemd.services.kanata = {
    description = "Kanata keyboard remapper";
    documentation = [ "https://github.com/jtroo/kanata" ];
    
    wantedBy = [ "default.target" ];
    wants = [ "display-manager.service" ];
    after = [ "display-manager.service" ];
    
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kanata}/bin/kanata --cfg /etc/kanata.kbd";
      ExecReload = "${pkgs.util-linux}/bin/kill -HUP $MAINPID";
      Restart = "always";
      RestartSec = 3;
    };
    
    enable = true;
  };
}
