# modules/hosts/cope/flake-parts.nix
#
# The only flake-parts module in the cope host directory.
# Calls mkNixos which wires inputs.self.modules.nixos.cope — the single
# merged NixOS module built up across all other files in this directory.
# hardware-configuration.nix is passed as an extraModule because it lives
# outside the module system.
{ self, ... }: {
  flake.nixosConfigurations = self.lib.mkNixos "x86_64-linux" "cope" [
    (self + "/hosts/cope/hardware-configuration.nix")
  ];
}
