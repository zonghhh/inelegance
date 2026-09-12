{ config, ... }: {
  imports = [
    # Mostly system related configuration
    ../../nixos/amd-graphics.nix
    ../../nixos/audio.nix
    ../../nixos/bluetooth.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/sddm.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/hyprland.nix
    ../../nixos/docker.nix
    ../../nixos/clamav.nix

    # host configs
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;
  hardware.enableRedistributableFirmware = true;

  # Don't touch this
  system.stateVersion = "26.05";
}
