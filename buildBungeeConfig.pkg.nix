{ pkgs ? import <nixpkgs> {}, nixpkgs, configs ? import ./src/config/bungeeConfig.nix, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "minecraft-bungee-server-config-builder";
  version = "v1.0.0";

  src = ./src;

  installPhase = let
    makeJSONfile = str: builtins.toFile str (builtins.toJSON configs.${str});
  in
  ''

  mkdir $out

  cp  ${makeJSONfile "config"} $out/config.yml
  cp BungeeCord.jar $out/server.jar

  '';

  meta = {
    description = "Minecraft Bungee Server Config Builder";
    homepage = "https://github.com/tnichols217/nix-minecrafterver";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}