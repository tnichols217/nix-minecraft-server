{ pkgs ? import <nixpkgs> {}, nixpkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "minecraft-server-config-builder";
  version = "v1.0.0";

  src = ./src/config;

  installPhase =''

  mkdir $out

  cp -l ${builtins.toFile (builtins.toJSON (import ./src/config/defaultConfig.nix {}).banned-ips)} $out/banned-ips.json

  '';

  meta = {
    description = "Minecraft Server Config Builder";
    homepage = "https://github.com/tnichols217/nix-minecraft-server";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}