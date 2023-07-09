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
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        spig = "${spigot}";
        bungee = "${bungeecord}";
      in
      {
        packages = rec {
          server = pkgs.callPackage ./server.pkg.nix { inherit nixpkgs; };

          configBungee = pkgs.callPackage ./buildBungeeConfig.pkg.nix { inherit nixpkgs; };
          packedBungee = pkgs.callPackage ./packConfig.pkg.nix { inherit nixpkgs; app = configBungee; name = "bungee"; };
          dockerBungee = pkgs.callPackage ./buildDocker.pkg.nix { inherit nixpkgs; app = packedBungee; startScript = ./src/bungeeStart.sh.pkg.nix; name = "bungee"; };
          
          config = pkgs.callPackage ./buildConfig.pkg.nix { inherit nixpkgs; };
          packed = pkgs.callPackage ./packConfig.pkg.nix { inherit nixpkgs; app = config; name = "survival"; };
          docker = pkgs.callPackage ./buildDocker.pkg.nix { inherit nixpkgs; app = packed; name = "survival"; };
          
          configCreative = pkgs.callPackage ./buildConfig.pkg.nix { inherit nixpkgs; configs = import ./src/config/creativeConfig.nix; };
          packedCreative = pkgs.callPackage ./packConfig.pkg.nix { inherit nixpkgs; app = configCreative; name = "creative"; };
          dockerCreative = pkgs.callPackage ./buildDocker.pkg.nix { inherit nixpkgs; app = packedCreative; name = "creative"; };
          
          default = dockerBungee;
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
          runArion = {
            type = "app";
            program = pkgs.callPackage ./nix/scripts/runArion.nix { };
          };
          default = runArion;
        };
      }
    )) // {
      arion-module = ./arion-compose.nix;
    };
}