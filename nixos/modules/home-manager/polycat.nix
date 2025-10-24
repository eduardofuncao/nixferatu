{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
	pname = "polycat";
	version = "2.0.0";

	src = fetchFromGitHub {
	  owner = "2IMT";
	  repo = "polycat";
	  rev = "v2.0.0";
	  sha256 = "sha256-wpDx6hmZe/dLv+F+kbo+YUIZ2A8XgnrZP0amkz6I5IQ=";
	};

	makeFlags = [
    "PREFIX=$(out)"
    "DEST_DIR="
  ];

}
