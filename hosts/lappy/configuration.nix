{ config, ... }: {
  imports = [
    # Core system modules
    ../../nixos/base/default.nix
    ../../nixos/desktop/default.nix

    # Desktop compositor and UI scaffolds
    ../../nixos/desktop/niri.nix
    ../../nixos/desktop/noctalia.nix
    ../../nixos/desktop/greeter.nix

    # Host-specific files
    ./hardware-configuration.nix
    ./variables.nix
  ];

  # Home-manager user config
  home-manager.users."${config.var.username}" = import ./home.nix;
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  # Don't touch this
  system.stateVersion = "26.05";
}
