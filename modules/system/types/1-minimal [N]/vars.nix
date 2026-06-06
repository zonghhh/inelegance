{ ... }: {
  # Host identity interface. Declarations only — values are set per host.
  flake.modules.nixos.vars =
    { lib, ... }:
    {
      options.var = {
        hostname = lib.mkOption { type = lib.types.str; };
        timezone = lib.mkOption {
          type = lib.types.str;
          default = "UTC";
        };
        locale = lib.mkOption {
          type = lib.types.str;
          default = "en_US.UTF-8";
        };
        keyboardLayout = lib.mkOption {
          type = lib.types.str;
          default = "us";
        };
      };
    };
}
