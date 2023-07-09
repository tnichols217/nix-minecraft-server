{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "podman-compose-wrapper";
  version = "v1.0.0";

  src = ./.;

  installPhase = ''

  mkdir -p $out/bin

  makeWrapper ${pkgs.arion}/libexec/arion $out/bin/arion \
        --unset PYTHONPATH \
        --prefix PATH : ${lib.makeBinPath [ pkgs.callPackage ./podman-compose-wrapper.pkg.nix {} ]} \
        ;

  '';

  meta = {
    description = "Minecraft Bungee Server Config Builder";
    homepage = "https://github.com/tnichols217/nix-minecrafterver";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}
