{ inputs, ... }: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-file.flakeModules.default
  ];

  # flake.nix is generated from the distributed flake-file.inputs declarations
  # across the tree. Regenerate with: nix run .#write-flake
  flake-file.description = "\"Elegance is more important than suffering. That's his design\". Anyways this is going to be incredibly inelegant...";
  flake-file.outputs = "dendritic";

  flake-file.inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-file.url = "github:vic/flake-file";
    import-tree.url = "github:vic/import-tree";
  };

  systems = [ "x86_64-linux" ];
}
