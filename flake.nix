{
  inputs = {
    spigot = {
      url = git+https://hub.spigotmc.org/stash/scm/spigot/buildtools.git;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages = rec {
        server = pkgs.callPackage ./server.pkg.nix {};
      };
    }
  )
}