{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "polycat";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "2IMT";
    repo = "polycat";
    rev = "f81e73bbb5de90a496bb0b844cdb3a93e54fbaad";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # You'll need to get the real hash
  };

  nativeBuildInputs = [ stdenv.cc ];

  makeFlags = [
    "PREFIX=${placeholder "out"}"
    "POLYCAT_RELEASE=1"
  ];

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin $out/share/fonts/TTF $out/share/polycat
    
    install -Dm755 build/polycat $out/bin/polycat
    install -Dm644 res/polycat.ttf $out/share/fonts/TTF/polycat.ttf
    install -Dm644 res/polycat-config $out/share/polycat/polycat-config
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "runcat module for polybar (or waybar) written in C++";
    homepage = "https://github.com/2IMT/polycat";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
