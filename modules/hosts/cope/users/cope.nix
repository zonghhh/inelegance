# modules/hosts/cope/users/cope.nix
#
# Opts the cope host into the cope user module.
# Mirrors the guide's pattern: hosts/homeserver/users/eve.nix imports
# the eve NixOS module and can add host-specific HM overrides.
{ inputs, ... }: {
  flake.modules.nixos.cope = {
    imports = with inputs.self.modules.nixos; [
      cope-user
    ];

    # Host-specific home-manager overrides for this user go here if needed
    # home-manager.users.cope = { ... };
  };
}
