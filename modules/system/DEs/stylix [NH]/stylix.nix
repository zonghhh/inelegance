{ inputs, ... }: {
  # System-wide theming for home-manager modules
  flake.modules.nixos.stylix = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];

    stylix = {
      enable = true;
      polarity = "dark";

      # auto generate colours from wallpaper
      image = inputs.self + "/wallpapers/wallpaper_whale.png";
    };
  };
}
