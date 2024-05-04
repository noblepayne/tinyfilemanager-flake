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
          tinyFileManager = pkgs.callPackage ./tinyFileManager.nix { };
          tinyFileManagerServer = pkgs.callPackage ./tinyFileManagerServer.nix { inherit tinyFileManager; };
        in
        rec {
          inherit tinyFileManager;
          inherit tinyFileManagerServer;
          default = tinyFileManagerServer;
        }
      );
    };
}
