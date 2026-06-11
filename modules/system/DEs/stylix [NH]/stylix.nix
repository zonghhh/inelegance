{ inputs, ... }: {
  # System-wide theming for home-manager modules
  flake.modules.nixos.stylix = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];

    stylix = {
      enable = true;
      polarity = "dark";

      # wallpaper.
      image = inputs.self + "/assets/wallpapers/wallpaper_girl.jpg";

      # leave pre-login surfaces untouched: the boot console log lines and the tuigreet greeter both render with the Linux console palette.
      targets.console.enable = false;

      # Fonts (applied system-wide + propagated to HM apps incl. caelestia).
      # TODO: find better way to get google fonts, as it stands it is around 2.7GB download.
      fonts = {
        monospace = {
          package = pkgs.google-fonts.override { fonts = [ "Cousine" ]; };
          name = "Cousine";
        };
        sansSerif = {
          package = pkgs.google-fonts.override { fonts = [ "Arimo" ]; };
          name = "Arimo";
        };
        serif = {
          package = pkgs.google-fonts.override { fonts = [ "Tinos" ]; };
          name = "Tinos";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };

      # Cursor theme.
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };
    };
  };
}
