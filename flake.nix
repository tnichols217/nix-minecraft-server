{
  inputs = {
    spigot = {
      url = git+https://hub.spigotmc.org/stash/scm/spigot/buildtools.git;
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, spigot, ... }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = rec {
          server = pkgs.callPackage ./server.pkg.nix {};
          spigot = pkgs.callPackage ./spigot.pkg.nix { spigotSrc = spigot; };
          default = spigot;
        };
      }
    );
}