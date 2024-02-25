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
  let
    sysOut = (flake-utils.lib.eachDefaultSystem (system:
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
          
          configCSDS = pkgs.callPackage ./buildConfig.pkg.nix { inherit nixpkgs; configs = import ./src/config/csdsConfig.nix; };
          packedCSDS = pkgs.callPackage ./packConfig.pkg.nix { inherit nixpkgs; app = configCSDS; name = "CSDS"; };
          dockerCSDS = pkgs.callPackage ./buildDocker.pkg.nix { inherit nixpkgs; app = packedCSDS; name = "CSDS"; };
          
          configSilas = pkgs.callPackage ./buildConfig.pkg.nix { inherit nixpkgs; configs = import ./src/config/silasConfig.nix; };
          packedSilas = pkgs.callPackage ./packConfig.pkg.nix { inherit nixpkgs; app = configCSDS; name = "Silas"; };
          dockerSilas = pkgs.callPackage ./buildDocker.pkg.nix { inherit nixpkgs; app = packedCSDS; name = "Silas"; };
          
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
          updateJars = {
            type = "app";
            program = pkgs.callPackage ./nix/scripts/updateJars.nix { };
          };
          runArion = {
            type = "app";
            program = pkgs.callPackage ./nix/scripts/runArion.nix { };
          };
          default = runArion;
        };
        overlays = self: super: {
            arion = import ./arion-wrapper.pkg.nix { pkgs = super; inherit self; };
            docker-compose = import ./podman-compose-wrapper.pkg.nix { pkgs = super; inherit self; };
            # docker = import ./podman-wrapper.pkg.nix { pkgs = super; inherit self; };
          };
      }
    ));
  in
    sysOut // {
      arion-module = import ./arion-config.nix { flake = sysOut.packages.x86_64-linux; };
    };
}