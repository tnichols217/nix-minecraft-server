{repoDir}: builtins.toFile getMavenInputs.sh ''

#!/usr/bin/env bash

upsearch () {
  local slashes=$\{PWD//[^\/]/}
  local directory=$(pwd)
  for (( n=$\{#slashes}; n>0; --n ))
  do
    test -e "$directory/$1" && cd $directory 
    directory="$directory/.."
  done
}

upsearch flake.nix

origin=`pwd`

cd repoDir
nix run github:fzakaria/mvn2nix#mvn2nix > $origin/maveninputs.nix

''