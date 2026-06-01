# modules/hosts/cope/hardware.nix
#
# Hardware-specific NixOS settings for this machine.
# nixos-hardware external modules are imported here since wrapping them
# as a feature in modules/ is the correct Dendritic approach for external code.
{ inputs, ... }: {
  flake.modules.nixos.cope = {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
      inputs.nixos-hardware.nixosModules.common-gpu-amd
    ];

    # Ensure the AMD GPU driver is loaded early
    boot.initrd.kernelModules = [ "amdgpu" ];

    hardware.graphics.enable = true;
    hardware.enableRedistributableFirmware = true;
  };
}
