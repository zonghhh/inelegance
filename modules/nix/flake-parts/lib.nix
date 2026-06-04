{ inputs, lib, ... }: {

  options.flake.lib = lib.mkOption {
    type    = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake.lib = {

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
