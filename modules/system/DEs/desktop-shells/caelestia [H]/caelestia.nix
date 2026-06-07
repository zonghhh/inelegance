{ inputs, ... }: {
  flake.modules.homeManager.caelestia =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      imports = [ inputs.caelestia-shell.homeManagerModules.default ];

      programs.caelestia = {
        enable = true;
        package = inputs.caelestia-shell.packages.${system}.default;
        # Autostart as a user service bound to graphical-session.target
        # (uwsm wires that target up for the hyprland session).
        systemd.enable = true;

        cli = {
          enable = true;
          package = inputs.caelestia-cli.packages.${system}.default;
        };
      };
    };
}
