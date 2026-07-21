{ inputs, ... }: {
  # bridges stylix -> noctalia colours.
  flake.modules.homeManager.noctalia =
    {
      pkgs,
      osConfig, # TOFIX: fix stylix.nix so we dont have to use OsConfig
      lib,
      ...
    }:
    {
      programs.noctalia.settings = {
        wallpaper = {
          enabled = true;
          default.path = "${osConfig.stylix.image}";
        };
  
        theme = {
          mode = "dark";
          source = lib.mkForce "wallpaper"; # TOFIX: temporary fix for upstream issue where source is written in stylix module.
          wallpaper_scheme = "m3-content"; # TODO: try the other generators (vibrant, muted, ...) and see what reads best against this wallpaper
        };
      };
    };
}
