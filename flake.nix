{
  inputs = {
    spigot = {
      url = git+https://hub.spigotmc.org/stash/scm/spigot/buildtools.git;
      flake = false;
    };
    bungeecord = {
      url = git+https://github.com/SpigotMC/BungeeCord;
      flake = false;
    };
    mavenix = {
      url = "github:nix-community/mavenix";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, spigot, mavenix, bungeecord, ... }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        spig = "${spigot}";
        bungee = "${bungeecord}";
      in
      {
        packages = rec {
          server = pkgs.callPackage ./server.pkg.nix { inherit nixpkgs; };
          config = pkgs.callPackage ./buildConfig.pkg.nix { inherit nixpkgs; };
          packed = pkgs.callPackage ./packConfig.pkg.nix { inherit nixpkgs; app = config; };
          docker = pkgs.callPackage ./buildDocker.pkg.nix { inherit nixpkgs; app = packed; };
          default = docker;
        };
        apps = rec {
          getSpigot = {
            type = "app";
            program = pkgs.callPackage ./nix/scripts/getSpigot.nix { inherit mavenix system; repoDir = spig; };
          };
          getBungeeCord = {
            type = "app";
            program = pkgs.callPackage ./nix/scripts/getBungee.nix { inherit mavenix system; repoDir = bungee; };
          };
          buildRun = {
            type = "app";
            program = ./scripts/buildRun.sh;
          };
          default = buildRun;
        };
      }
    );
}