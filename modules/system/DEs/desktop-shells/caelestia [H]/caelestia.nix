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

      # shell.json is managed by home-manager (read-only symlink) but caelestia
      # needs to write to it at runtime: replace the symlink with a mutable copy.
      # The stale .hm-backup must be removed before linkGeneration so HM can
      # back up the runtime-modified shell.json without hitting a conflict.
      home.activation.caelestiaCleanBackup = config.lib.dag.entryBefore [ "linkGeneration" ] ''
        $DRY_RUN_CMD rm -f "$HOME/.config/caelestia/shell.json.backup"
      '';
      home.activation.caelestiaWritableConfig = config.lib.dag.entryAfter [ "linkGeneration" ] ''
        if [ -L "$HOME/.config/caelestia/shell.json" ]; then
          $DRY_RUN_CMD cp --remove-destination \
            "$(readlink -f "$HOME/.config/caelestia/shell.json")" \
            "$HOME/.config/caelestia/shell.json"
        fi
      '';
    };
}
