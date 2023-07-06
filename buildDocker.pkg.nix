{ pkgs, app, name ? "minecraft", ... }:
pkgs.dockerTools.buildImage {
  inherit name;
  copyToRoot = pkgs.buildEnv {
    inherit name;
    paths = [ app ];
    pathsToLink = [ "/bin" ];
  };
  config = {
    Cmd = [ "${pkgs.bash}/bin/bash" "${pkgs.callPackage ./src/start.sh.pkg.nix { inherit name; }}"];
    Volumes = { };
    WorkingDir = "/bin/${name}";
  };
}