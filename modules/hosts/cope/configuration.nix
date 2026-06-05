{ inputs, ... }: {
  flake.modules.nixos.cope = {
    imports = with inputs.self.modules.nixos; [
      system-hyprland
      greeter
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.caelestia ];
  };
}
