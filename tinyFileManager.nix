{ fetchFromGitHub, stdenv }:
stdenv.mkDerivation {
  name = "tinyfilemanager";
  src = fetchFromGitHub {
    owner = "prasathmani";
    repo = "tinyfilemanager";
    rev = "2.5.0";
    hash = "sha256-taKADcmduazrw03jz0OTc62dWNE85x9WJ1XsQHzU/Kg=";
  };
  dontBuild = true;
  installPhase = ''
    mkdir $out
    cp -r * $out/
  '';
}
