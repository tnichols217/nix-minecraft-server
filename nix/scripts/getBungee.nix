{ pkgs, repoDir, system, mavenix, ... }: "${(pkgs.writeShellScriptBin "getJar.sh" ''

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

origin=`pwd`
tt=`mktemp -d`

cd ${repoDir}
cp -r * .* $tt
cd $tt
pwd
${mavenix.packages.${system}.mavenix-cli}/bin/mvnix-init
${mavenix.packages.${system}.mavenix-cli}/bin/mvnix-update
nix-build

rm -f $origin/src/BungeeCord.jar
cp result/share/java/BungeeCord.jar $origin/src

'')}/bin/getJar.sh"