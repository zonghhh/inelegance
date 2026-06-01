# modules/nix/flake-parts/dendritic-tools.nix
#
# Imports flake-parts' built-in `modules` flake module, which is what actually
# defines the `flake.modules.*` option used throughout the config.
# Without this, none of the `flake.modules.nixos.X = ...` assignments work.
# Also sets the systems list required by flake-parts.
{ inputs, ... }: {
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  systems = [ "x86_64-linux" ];
}
