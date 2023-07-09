{ pkgs ? import <nixpkgs> {}, self ? import <nixpkgs> {}, lib, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "podman-compose-wrapper";
  version = "v1.0.0";
  nativeBuildInputs = [ pkgs.makeWrapper ];


  src = ./.;

  postFixup = let
    arion = "${pkgs.arion}";
    podman = pkgs.callPackage ./podman-compose-wrapper.pkg.nix { inherit self; };
  in ''

  mkdir -p $out/bin

  makeWrapper ${arion}/libexec/arion $out/bin/arion \
        --unset PYTHONPATH \
        --prefix PATH : ${lib.makeBinPath [ podman ]} \
        ;

  '';

  meta = {
    description = "Minecraft Bungee Server Config Builder";
    homepage = "https://github.com/tnichols217/nix-minecrafterver";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}
