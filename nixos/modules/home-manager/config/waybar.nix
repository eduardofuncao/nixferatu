{ pkgs, stylix, ... }:

{
  # Enable waybar with custom config
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        "modules-left" = [ "custom/nixos" ];
        "modules-center" = [ "custom/polycat" ];
        "modules-right" = [ "battery" "network" "pulseaudio" "memory" "clock" ];

        network = {
          interface = "wlp0s20f3";
          "format-wifi" = "{icon}";
          "format-ethernet" = "{ifname}: {ipaddr} {icon}";
          "format-disconnected" = "{icon}";
          "format-icons" = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          "format-icons-disconnected" = "󰤭";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%)";
        };

        pulseaudio = {
          format = "{icon}";
          "format-bluetooth" = "{icon}";
          "format-muted" = "";
          "format-icons" = {
            default = [ "" "" "" ];
          };
          "scroll-step" = 1;
          "on-click" = "pavucontrol";
          "ignored-sinks" = [ "Easy Effects Sink" ];
          "tooltip-format" = "{icon} {volume}%";
        };

        memory = {
          interval = 5;
          format = "{icon}";
          "format-icons" = [ "○" "◔" "◑" "◕" "●" ];
          "tooltip-format" = "󰍛 {used:0.1f}G/{total:0.1f}G, {percentage}%";
        };

        clock = {
          format = "  {:%H:%M %a %d %b}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        battery = {
          format = "{icon}";
          "format-icons" = {
            charging = [ "󰢟" "󰂆" "󰢝" "󰢞" "󰂅" ];
            discharging = [ "󰂎" "󰁻" "󰁾" "󰂀" "󰁹" ];
            full = [ "󰁹" ];
          };
          "format-alt" = "{time} {icon}";
          "tooltip-format" = "{capacity}%";
          interval = 10;
        };

        "custom/polycat" = {
          format = "{}";
          exec = "polycat";
        };

        "custom/nixos" = {
          format = "";
          tooltip = false;
          interval = 3600;
        };
      };
    };

    style = ''

      #battery {
        margin:0 1.5px;
      }

      #memory {
        padding-bottom: 2.5px;
      }

      #clock {
        margin-right: 2.5px;
      }

      #custom-polycat {
          font-size: 20px;
      }

      #custom-nixos {
          font-size: 20px;
	  margin-left: 2.5px;
      }
    '';
  };
}
