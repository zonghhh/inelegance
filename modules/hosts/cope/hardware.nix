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
