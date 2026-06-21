{ inputs, ... }: {
  flake.modules.nixos.cope = {
    imports = with inputs.self.modules.nixos; [
      system-desktop

      niri
      systemd-boot
      bluetooth
    ];
  };
}
