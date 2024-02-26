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
    csds = {
      service = {
        depends_on = [];
        expose = ["25565"];
        restart = "unless-stopped";
        volumes = [
          "world-data:/mnt"
        ];
      };
      build.image = lib.mkForce (flake.dockerCSDS);
    };
    sil = {
      service = {
        depends_on = [];
        expose = ["25565"];
        restart = "unless-stopped";
        volumes = [
          "world-data:/mnt"
        ];
      };
      build.image = lib.mkForce (flake.dockerSilas);
    };
    bungee = {
      service = {
        depends_on = [ "survival" "creative" "csds" "sil" ];
        ports = ["25565:25565"];
        restart = "unless-stopped";
      };
      build.image = lib.mkForce (flake.dockerBungee);
    };
  };
} // {
  # docker-compose = if isCompose then 
  docker-compose = if false then 
  {
    raw.volumes = lib.mkForce {
      world-data = {

      };
    };
  }
  else
  {
    volumes = lib.mkForce {
      world-data = {
        driver = "local";
        driver_opts = {
          type = "none";
          o = "bind";
          device = "/var/lib/container-storage/volumes/minecraft/";
        };
      };
    };
  };
}