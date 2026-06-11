{ inputs, ... }: {
  flake.modules.homeManager.caelestia =
    {
      pkgs,
      config,
      osConfig,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      imports = [ inputs.caelestia-shell.homeManagerModules.default ];

      programs.caelestia = {
        enable = true;
        package = inputs.caelestia-shell.packages.${system}.default;
        # autostart as a user service bound to graphical-session.target (uwsm wires that target up for the hyprland session).
        systemd.enable = true;

        # cli.package is set in scheme.nix (the themed override) so the option
        # has a single owner — avoids a merge conflict and the mkForce it needs.
        cli.enable = true;

        settings = {
          # stylix already renders the wallpaper (auto hyprpaper service)
          background.enabled = false;

          # use stylix's fonts for the shell UI.
          appearance.font.family = {
            sans = config.stylix.fonts.sansSerif.name;
            mono = config.stylix.fonts.monospace.name;
          };

          # weather location comes from the host's var interface, osConfig allows reading of NixOS options directly within user configurations
          services.weatherLocation = osConfig.var.weatherLocation;
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
          # Store files are mode 0444; make it writable so the shell can save.
          $DRY_RUN_CMD chmod u+w "$HOME/.config/caelestia/shell.json"
        fi
      '';
    };
}
