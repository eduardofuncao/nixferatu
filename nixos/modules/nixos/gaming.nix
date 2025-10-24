{ config, pkgs, ... }:

{
  # Enable gaming-related services and configurations
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Intel GPU configuration for ThinkPad T480
  services.xserver.videoDrivers = [ "modesetting" ];
  
  # Intel graphics hardware acceleration
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # VAAPI driver for modern Intel GPUs
      vaapiIntel         # Legacy VAAPI driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Gaming packages
  environment.systemPackages = with pkgs; [
    lutris
    heroic
    mangohud
    gamemode
    discord
    # Additional tools for Intel graphics
    intel-gpu-tools
    mesa-demos
  ];

  # Performance optimizations for laptop
  powerManagement.cpuFreqGovernor = "performance";
  
  # Kernel parameters optimized for ThinkPad T480
  boot.kernelParams = [
    "i915.enable_guc=2"  # Enable GuC submission for Intel graphics
    "i915.enable_fbc=1"  # Enable framebuffer compression
  ];

  # Enable TLP for better battery management when gaming unplugged
  services.tlp = {
    enable = true;
    settings = {
      # Performance mode when on AC power
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      # GPU performance settings
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  # Thermal management for sustained performance
  services.thermald.enable = true;
}
