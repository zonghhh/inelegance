# modules/users/cope/homeManager.nix
#
# Defines flake.modules.homeManager.cope — the home-manager configuration
# for this user. Intentionally minimal for now. As you migrate your shell,
# hyprland config, caelestia, and program modules over, add them here as
# imports via inputs.self.modules.homeManager.<feature>.
{ ... }: {
  flake.modules.homeManager.cope = { ... }: {
    home.username      = "zh";
    home.homeDirectory = "/home/zh";
    home.stateVersion  = "25.05";

    programs.bash.enable         = true;
    programs.home-manager.enable = true;
  };
}
