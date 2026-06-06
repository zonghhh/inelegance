{ ... }: {
  flake.modules.nixos.greeter =
    { config, pkgs, ... }:
    let
      # Launch the configured compositor; fall back to letting tuigreet prompt
      # for a command when none is set. var.sessionCommand comes from the
      # compositor that bundles this greeter (via the `session` interface).
      cmd = config.var.sessionCommand;
      sessionArg = if cmd != null then " --cmd '${cmd}'" else "";
    in
    {
      services.greetd = {
        enable = true;
        settings.default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember${sessionArg}";
          user = "greeter";
        };
      };

      security.pam.services.greetd.enableGnomeKeyring = true;
    };
}
