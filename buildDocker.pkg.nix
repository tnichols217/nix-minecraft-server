{ pkgs, app, name ? "minecraft", startScript ? ./src/start.sh.pkg.nix, ... }:
pkgs.dockerTools.buildImage {
  inherit name;
  copyToRoot = pkgs.buildEnv {
    inherit name;
    paths = [ app pkgs.bash ];
    pathsToLink = [ "/bin" ];
  };
  config = {
    Cmd = [ "${pkgs.bash}/bin/bash" "${pkgs.callPackage startScript { inherit name; }}/bin/run.sh" ];
    Volumes = { };
    WorkingDir = "/bin/${name}";
  };
}