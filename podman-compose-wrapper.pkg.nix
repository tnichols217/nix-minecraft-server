{ pkgs ? import <nixpkgs> {}, self ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "podman-compose-wrapper";
  version = "v1.0.0";

  src = ./.;

  installPhase = let
    pod = "${self.podman-compose}";
  in ''

  mkdir -p $out/bin

  ln -s ${pod}/bin/podman-compose $out/bin/docker-compose

  '';

  meta = {
    description = "Minecraft Bungee Server Config Builder";
    homepage = "https://github.com/tnichols217/nix-minecrafterver";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}