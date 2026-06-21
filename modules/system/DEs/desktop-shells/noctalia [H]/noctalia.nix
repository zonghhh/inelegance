{ inputs, ... }: {
  flake.modules.homeManager.noctalia =
    { pkgs, osConfig, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      imports = [ inputs.noctalia.homeModules.default ];

      programs.noctalia = {
        enable = true;
        package = inputs.noctalia.packages.${system}.default;

        # autostart as a user service bound to graphical-session.target, same
        # rationale as caelestia.systemd.enable — uwsm wires the target up.
        systemd = {
          enable = true;
          # recommended whenever systemd.enable is on: apps Noctalia spawns
          # would otherwise die when the service restarts (e.g. on update).
          launch_apps_as_systemd_services = true;
        };

        settings = {
          # theme.source / wallpaper_scheme live in scheme.nix, which points
          # noctalia's colour extraction at the stylix wallpaper — kept out
          # of this file to avoid two modules both trying to set theme.source.
          theme.mode = "dark";

          services.weatherLocation = osConfig.var.weatherLocation;
        };
      };
    };
}

