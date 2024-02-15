{ pkgs ? import <nixpkgs> {}, nixpkgs, configs ? import ./src/config/defaultConfig.nix, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "minecraft-server-config-builder";
  version = "v1.0.0";

  src = ./src;

  installPhase = let
    makeJSONfile = str: builtins.toFile str (builtins.toJSON configs.${str});
    makeKeyfile = str: builtins.toFile str (pkgs.lib.generators.toKeyValue {} configs.${str});
  in
  ''

  mkdir $out

  cp  ${makeJSONfile "banned-ips"} $out/banned-ips.json
  cp  ${makeJSONfile "banned-players"} $out/banned-players.json
  cp  ${makeJSONfile "bukkit"} $out/bukkit.yml
  cp  ${makeJSONfile "commands"} $out/commands.yml
  cp  ${makeKeyfile "eula"} $out/eula.txt
  cp  ${makeJSONfile "help"} $out/help.yml
  cp  ${makeJSONfile "ops"} $out/ops.json
  cp  ${makeJSONfile "permissions"} $out/permissions.yml
  cp  ${makeKeyfile "server"} $out/server.properties
  cp  ${makeJSONfile "spigot"} $out/spigot.yml
  cp  ${makeJSONfile "usercache"} $out/usercache.json
  cp  ${makeJSONfile "whitelist"} $out/whitelist.json
  echo "[regex].*\n/mnt" > $out/allowed_symlinks.txt
  cp server.jar $out/server.jar
  mkdir -p $out/world/datapacks
  cp datapacks/* $out/world/datapacks

  '';

  meta = {
    description = "Minecraft Server Config Builder";
    homepage = "https://github.com/tnichols217/nix-minecrafterver";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}