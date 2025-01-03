{
  description = "Nix Flake templates";

  inputs = { };

  outputs = { self }: {
    templates = {
      default = {
        path = ./default;
      };
    };
  };
}
