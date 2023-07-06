{ pkgs ? import <nixpkgs> {}, nixpkgs, app, name ? "minecraft", ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "minecraft-server-config-packer";
  version = "v1.0.0";

  src = ./src;

  installPhase = ''

  mkdir $out
  mkdir -p $out/bin/${name}
  cp -r ${app}/* ${app}/.* $out/bin/${name} 

  '';

  meta = {
    description = "Minecraft Server Config Packer";
    homepage = "https://github.com/tnichols217/nix-minecrafterver";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}