# modules/hosts/cope/variables.nix
#
# Sets the `var` option defined in system/types/1-minimal.
# Contributes to flake.modules.nixos.cope alongside all other host files.
{ ... }: {
  flake.modules.nixos.cope = { ... }: {
    var = {
      username       = "zh";
      hostname       = "cope";
      timezone       = "Asia/Singapore";
      locale         = "en_GB.UTF-8";
      keyboardLayout = "us";
    };
  };
}
