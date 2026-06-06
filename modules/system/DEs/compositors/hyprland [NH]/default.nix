{ inputs, ... }: {
  # A compositor aspect — orthogonal to system-desktop. A desktop host composes
  # both (see hosts/cope). Bundles its greeter (session interface) and shell.
  flake.modules.nixos.hyprland = { pkgs, ... }: {
    imports = with inputs.self.modules.nixos; [
      session
      greeter
    ];

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    programs.uwsm.enable = true;

    # Tell the bundled greeter how to launch this compositor.
    var.sessionCommand = "uwsm start hyprland-uwsm.desktop";

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      hyprland
      caelestia
    ];
  };

  flake.modules.homeManager.hyprland.wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = null;
    portalPackage = null;
  };
}
