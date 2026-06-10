{ inputs, ... }: {
  flake.modules.homeManager.caelestia =
    { pkgs, config, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      imports = [ inputs.caelestia-shell.homeManagerModules.default ];

      programs.caelestia = {
        enable = true;
        package = inputs.caelestia-shell.packages.${system}.default;
        # Autostart as a user service bound to graphical-session.target (uwsm wires that target up for the hyprland session).
        systemd.enable = true;

        cli = {
          enable = true;
          package = inputs.caelestia-cli.packages.${system}.default;
        };

        settings = {
          # Stylix already renders the wallpaper (auto hyprpaper service)
          background.enabled = false;

          # Use stylix's fonts for the shell UI.
          appearance.font.family = {
            sans = config.stylix.fonts.sansSerif.name;
            mono = config.stylix.fonts.monospace.name;
          };
        };
      };
    };
}
