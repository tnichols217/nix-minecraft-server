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
chmod -R 755 *
${pkgs.maven}/bin/mvn package

rm -f $origin/src/BungeeCord.jar
cp bootstrap/target/BungeeCord.jar $origin/src

'')}/bin/getJar.sh"