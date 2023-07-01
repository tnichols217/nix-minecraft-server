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
        spig = "${spigot}";
      in
      {
        packages = rec {
          server = pkgs.callPackage ./server.pkg.nix {};
          spigot = pkgs.callPackage ./spigot.pkg.nix { spigotSrc = spig; };
          default = spigot;
        };
        apps = rec {
          getMavenInputs = pkgs.callPackage ./nix/scripts/getMavenInput.nix { repoDir = spig; };
          default = getMavenInputs;
        };
      }
    );
}