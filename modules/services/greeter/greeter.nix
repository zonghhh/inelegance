# modules/services/greeter/greeter.nix
#
# greetd display manager with tuigreet, launching Hyprland via UWSM.
# Named greeter.nix following the guide's convention of naming the file
# after the feature it defines.
{ ... }: {
  flake.modules.nixos.greeter = { pkgs, ... }: {
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --remember \
            --cmd "uwsm start hyprland-uwsm.desktop"
        '';
        user = "greeter";
      };
    };

    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
