{ ... }: {
  # Compositor SETS var.sessionCommand; the greeter READS it.
  flake.modules.nixos.session =
    { lib, ... }:
    {
      options.var.sessionCommand = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          Command launched after login (by the greeter, or by the TTY login
          shell when no greeter is present). Set by the active compositor.
          null means no compositor is configured.
        '';
      };
    };
}
