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
${pkgs.jdk23}/bin/java -jar target/BuildTools.jar
rm -f $origin/src/server.jar
cp spigot*.jar $origin/src
cd $origin/src
mv spigot*.jar server.jar
rm -rf $tt

'')}/bin/getJar.sh"