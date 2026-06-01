# modules/nix/tools/home-manager/home-manager.nix
#
# Registers home-manager as a named NixOS feature module.
# Imported by system-default, so any host that uses system-default
# (or any type that inherits from it) gets home-manager automatically.
# Mirrors how the guide handles this — as a feature, not a hardwired import.
{ inputs, ... }: {
  flake.modules.nixos.home-manager = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager = {
      useGlobalPkgs   = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}
