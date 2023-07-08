{ pkgs, ... }:
let
  flake = (builtins.getFlake (toString ./.)).packages.x86_64-linux;
in
{
  project.name = "minecraft";
  services = {
    survival = {
      service = {
        depends_on = [];
        expose = ["25565"];
        restart = "unless-stopped";
      };
      build.image = lib.mkForce (flake.docker);
    };
    creative = {
      service = {
        depends_on = [];
        expose = ["25565"];
        restart = "unless-stopped";
      };
      build.image = lib.mkForce (flake.dockerCreative);
    };
    bukkit = {
      service = {
        depends_on = [ "survival" "creative" ];
        ports = ["25565:25565"];
        restart = "unless-stopped";
      };
      build.image = lib.mkForce (flake.dockerBukkit);
    };
  };
}