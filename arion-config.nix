{ flake ? (builtins.getFlake (toString ./.)).packages.x86_64-linux, isCompose ? false, ... }:
{ lib, ... }:
{
  project.name = "minecraft";
  docker-compose.volumes = lib.mkForce {
    world-data = {};
  };
  services = {
    survival = {
      service = {
        depends_on = [];
        expose = ["25565"];
        restart = "unless-stopped";
        volumes = [
          "world-data:/mnt"
        ];
      };
      build.image = lib.mkForce (flake.docker);
    };
    creative = {
      service = {
        depends_on = [];
        expose = ["25565"];
        restart = "unless-stopped";
        volumes = [
          "world-data:/mnt"
        ];
      };
      build.image = lib.mkForce (flake.dockerCreative);
    };
    bungee = {
      service = {
        depends_on = [ "survival" "creative" ];
        ports = ["25565:25565"];
        restart = "unless-stopped";
      };
      build.image = lib.mkForce (flake.dockerBungee);
    };
  };
} // {
  docker-compose = let
    val = lib.mkForce {
      world-data = {};
    };
  in if isCompose then { raw.volumes = val; } else { volumes = val; };
}