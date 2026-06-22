{ inputs, ... }: {
  # bridges stylix -> noctalia colours.
  flake.modules.homeManager.noctalia =
    {
      pkgs,
      osConfig,
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
          source = "wallpaper";
          wallpaper_scheme = "m3-content"; # TODO: try the other generators (vibrant, muted, ...) and see what reads best against this wallpaper
        };
      };
    };
}
