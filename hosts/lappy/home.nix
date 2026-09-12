{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [

    ./variables.nix # Mostly user-specific configuration
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    persistence."/persist" = lib.mkIf (config.var.impermanenceEnabled or false) {
      directories = [
        ".config/nixos" # this repo itself (nixy manages it here)
        ".local/share"
        ".local/state"
        ".cache"
        ".steam"
        "Dev"
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
      ];

      files = [
        ".ssh/known_hosts"
        ".config/sops/age/keys.txt"
      ];
    };

    # TOFIX: laptop dont have GPU probably, check this
    # sessionVariables = {
    #   AQ_DRM_DEVICES = "/dev/dri/card2:/dev/dri/card1"; # CHANGEME: Related to the GPU
    # };

    # Don't touch this
    stateVersion = "26.05";
  };

  # TOFIX: find the equivalent for niri
  # wayland.windowManager.hyprland.settings.monitor = [
  #   "eDP-2,highres,0x0,1" # My internal laptop screen
  #   "desc:AOC U34G2G1 0x00000E06,3440x1440@99.98,auto,1" # My external monitor
  # ];

  programs.home-manager.enable = true;
}