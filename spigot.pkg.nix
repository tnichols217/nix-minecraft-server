{ pkgs ? import <nixpkgs> {}, spigotSrc, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "minecraft-server-builder";
  version = "v1.0.0";
  nativeBuildInputs = [pkgs.git];

  src = spigotSrc;

  buildPhase = ''
    ${pkgs.maven + "/bin/mvn"} --offline clean install
  '';

  installPhase =''

  mkdir $out

  cp -r * $out

  '';

  meta = {
    description = "Minecraft Server Builder";
    homepage = "https://github.com/tnichols217/nix-minecraft-server";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}