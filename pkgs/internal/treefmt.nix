pkgs:
let
  flake-lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  treefmt-nix = builtins.getFlake (builtins.flakeRefToString flake-lock.nodes.treefmt-nix.locked);

  treefmtEval = treefmt-nix.lib.evalModule pkgs treefmtConfig;

  treefmtConfig = {
    projectRootFile = "flake.nix";
    # keep-sorted start
    programs.actionlint.enable = true;
    programs.deadnix.enable = true;
    programs.keep-sorted.enable = true;
    programs.nixfmt.enable = true;
    programs.prettier.enable = true;
    programs.statix.enable = true;
    # keep-sorted end
  };
in
treefmtEval.config.build
