# modules/system/types/2-default/default.nix
#
# Builds on system-minimal by adding the essential Nix tools
# that every host in this config uses: home-manager.
# Add secrets, impermanence etc. here when you bring them over.
{ inputs, ... }: {
  flake.modules.nixos.system-default = {
    imports = with inputs.self.modules.nixos; [
      system-minimal
      home-manager
    ];
  };
}
