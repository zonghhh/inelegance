{ self, ... }: {
  flake.nixosConfigurations = self.lib.mkNixos "x86_64-linux" "cope" [
    (self + "/hosts/cope/hardware-configuration.nix")
  ];

  flake-file.inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
}
