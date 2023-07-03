{
  inputs = {
    spigot = {
      url = git+https://hub.spigotmc.org/stash/scm/spigot/buildtools.git;
      flake = false;
    };
    mvn2nix = {
      url = "github:fzakaria/mvn2nix";
    };
    mavenix = {
      url = "github:nix-community/mavenix";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, spigot, mvn2nix, mavenix, ... }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        spig = "${spigot}";
      in
      {
        packages = rec {
          server = pkgs.callPackage ./server.pkg.nix { inherit nixpkgs; };
          config = pkgs.callPackage ./buildConfig.pkg.nix { inherit nixpkgs; };
          default = config;
        };
        apps = rec {
          getMavenInputs = {
            type = "app";
            program = pkgs.callPackage ./nix/scripts/getJar.nix { inherit mavenix system; repoDir = spig; };
          };
          default = getMavenInputs;
        };
      }
    );
}