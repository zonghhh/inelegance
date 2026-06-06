{ inputs, ... }: {
  flake.modules.nixos.cope = {
    imports = with inputs.self.modules.nixos; [
      system-hyprland
      systemd-boot
      bluetooth
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.caelestia ];
  };
}
