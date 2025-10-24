{ pkgs, lib, ... }:

let
  web-agent-unwrapped = pkgs.stdenv.mkDerivation rec {
    pname = "web-agent-unwrapped";
    version = "1.0.0";

    src = ./web-agent.deb;

    nativeBuildInputs = with pkgs; [ dpkg ];

    unpackPhase = ''
      dpkg-deb -x $src .
    '';

    installPhase = ''
      mkdir -p $out
      # Copy everything maintaining the original structure
      cp -r opt $out/
      cp -r usr $out/
      
      # Make binaries executable
      chmod +x $out/opt/web-agent/web-agent
      find $out -name "*.so*" -exec chmod +x {} \;
    '';
  };

in
pkgs.buildFHSEnv {
  name = "web-agent";
  
  targetPkgs = pkgs: with pkgs; [
    # Base system
    glibc
    stdenv.cc.cc.lib
    
    # GLib ecosystem (this is what's missing)
    glib
    gobject-introspection
    
    # GUI libraries
    gtk3
    gdk-pixbuf
    cairo
    pango
    atk
    at-spi2-atk
    at-spi2-core
    
    # X11 libraries
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXfixes
    
    # Wayland libraries (just in case)
    wayland
    libxkbcommon
    
    # System libraries
    dbus
    systemd
    libuuid
    expat
    zlib
    
    # App indicator libraries (if available)
    libappindicator-gtk3
    libdbusmenu-gtk3
    
    # Other common libraries
    alsa-lib
    cups
    libGL
    mesa
    nspr
    nss
    fontconfig
    freetype
    
    # Additional libraries that might be needed
    libnotify
    libsecret
    keyutils
    krb5
  ];

  multiPkgs = pkgs: with pkgs; [
    # Add 32-bit versions if the app needs them
    glib
  ];

  extraBuildCommands = ''
    # Create the directory structure
    mkdir -p $out/opt/web-agent
    mkdir -p $out/usr/share/applications
    mkdir -p $out/usr/share/icons
    
    # Copy files from the unwrapped package
    cp -r ${web-agent-unwrapped}/opt/web-agent/* $out/opt/web-agent/
    cp -r ${web-agent-unwrapped}/usr/share/applications/* $out/usr/share/applications/
    cp -r ${web-agent-unwrapped}/usr/share/icons/* $out/usr/share/icons/
  '';

  runScript = pkgs.writeScript "web-agent-runner" ''
    #!/bin/bash
    
    # Set up additional environment variables that might be needed
    export GIO_MODULE_DIR=${pkgs.glib-networking}/lib/gio/modules
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:/usr/share"
    
    # Change to the application directory
    cd /opt/web-agent
    
    # Run the application
    exec ./web-agent "$@"
  '';

  meta = with lib; {
    description = "Web Agent application";
    platforms = platforms.linux;
  };
}
