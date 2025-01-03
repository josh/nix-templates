final: prev: {
  example = final.lib.packagesFromDirectoryRecursive {
    callPackage = final.callPackage;
    directory = ./pkgs;
  };
}
