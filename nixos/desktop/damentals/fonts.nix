# Fonts configuration for NixOS
{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-sans
    ];

    enableDefaultPackages = false; # TOFIX: check true vs false options
  };
}