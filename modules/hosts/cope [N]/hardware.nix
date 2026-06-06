{ inputs, ... }: {
  flake.modules.nixos.cope = {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
      inputs.nixos-hardware.nixosModules.common-gpu-amd
    ];

    boot.initrd.kernelModules = [ "amdgpu" ];

    hardware.graphics.enable = true;
  };
}
