# modules/nix/flake-parts/lib.nix
#
# Helper functions for building system configurations.
# Mirrors the guide's lib.nix pattern.
#
# mkNixos wires up a single named nixosConfiguration by pulling
# inputs.self.modules.nixos.<name> — the merged NixOS module that all
# files in modules/hosts/<name>/ have contributed to.
{ inputs, lib, ... }: {

  options.flake.lib = lib.mkOption {
    type    = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake.lib = {

    # mkNixos "x86_64-linux" "cope" [ extraModule1 extraModule2 ]
    # extraModules: for things that live outside the module system
    # (e.g. the auto-generated hardware-configuration.nix)
    mkNixos = system: name: extraModules: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}
          { nixpkgs.hostPlatform = lib.mkDefault system; }
        ] ++ extraModules;
      };
    };

  };
}
