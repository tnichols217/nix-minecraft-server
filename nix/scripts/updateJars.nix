{ pkgs, ... }: "${(pkgs.writeShellScriptBin "getJar.sh" ''

#!/usr/bin/env bash

upsearch () {
  local slashes=''\${PWD//[^\/]/}
  local directory=$(pwd)
  for (( n=''\${#slashes}; n>0; --n ))
  do
    test -e "$directory/$1" && cd $directory 
    directory="$directory/.."
  done
}

upsearch flake.nix

nix run .#getSpigot
nix run .#getBungeeCord

'')}/bin/getJar.sh"