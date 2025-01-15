{
  description = "Flake for foo package";

  nixConfig = {
    extra-substituters = [
      "https://josh.cachix.org"
    ];
    extra-trusted-public-keys = [
      "josh.cachix.org-1:qc8IeYlP361V9CSsSVugxn3o3ZQ6w/9dqoORjm0cbXk="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      eachSystem = lib.genAttrs systems;
      eachPkgs = f: eachSystem (system: f (nixpkgs.legacyPackages.${system}.extend self.overlay));

      treefmt-nix = eachPkgs (import ./internal/treefmt.nix);
    in
    {
      packages = eachPkgs (pkgs: lib.filterAttrs (_: pkg: pkg.meta.available) pkgs.example);

      overlay = self.overlays.default;
      overlays.default = import ./overlay.nix;

      formatter = eachSystem (system: treefmt-nix.${system}.wrapper);
      checks = eachSystem (system: {
        formatting = treefmt-nix.${system}.check self;
      });
    };
}
