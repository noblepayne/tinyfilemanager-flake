{
  description = "Basic flake for tinyfilemanager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
    }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        rec {
          tinyfilemanager = pkgs.stdenv.mkDerivation {
            name = "tinyfilemanager";
            src = pkgs.fetchFromGitHub {
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
          };
          serve = pkgs.writeShellApplication {
            name = "serve";
            runtimeInputs = [
              pkgs.coreutils # better stat on macos?
              pkgs.php
              tinyfilemanager
            ];
            text = ''
              php -S 127.0.0.1:9999 "${tinyfilemanager}/tinyfilemanager.php"
            '';
          };
          default = serve;
        }
      );
    };
}
