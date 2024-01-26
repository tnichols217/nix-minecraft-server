{ pkgs ? import <nixpkgs> {}, self ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "podman-wrapper";
  version = "v1.0.0";

  src = ./.;

  installPhase = let
    podman = "${self.podman}";
  in ''

  mkdir -p $out/bin $out/libexec/docker

  ln ${podman}/bin/podman $out/bin/docker
  ln ${podman}/bin/podman $out/libexec/docker/docker

  '';

  meta = {
    description = "Minecraft Bungee Server Config Builder";
    homepage = "https://github.com/tnichols217/nix-minecrafterver";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}