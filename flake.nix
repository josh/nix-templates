{
  description = "Nix Flake templates";

  inputs = { };

  outputs = { self }: {
    templates = {
      pkgs = {
        path = ./pkgs;
        description = "A flake providing packages in callPackage format";
      };

      default = self.templates.pkgs;
    };
  };
}
