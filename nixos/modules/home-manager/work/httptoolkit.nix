{ pkgs, lib ? pkgs.lib }:

pkgs.appimageTools.wrapType2 {
  pname = "httptoolkit";
  version = "1.22.1";
  src = ./HttpToolkit-1.22.1-x64.AppImage;

  extraInstallCommands = ''
    # Install desktop entry
    mkdir -p $out/share/applications
    cat > $out/share/applications/httptoolkit.desktop << EOF
[Desktop Entry]
Name=HTTP Toolkit
Comment=Beautiful & powerful HTTP(S) proxy, analyzer, and client
Exec=$out/bin/httptoolkit
Icon=httptoolkit
Type=Application
Categories=Development;Network;
StartupWMClass=httptoolkit
Terminal=false
EOF
  '';

  meta = with lib; {
    description = "Beautiful & powerful HTTP(S) proxy, analyzer, and client";
    homepage = "https://httptoolkit.tech/";
    license = licenses.agpl3Plus;
    platforms = platforms.linux;
    maintainers = [ ];
    mainProgram = "httptoolkit";
  };
}
