{ ... }: {
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts = {
        # stylix handles the themed serif/sans/mono/emoji families
        enableDefaultPackages = true; # TODO: check if this fallback is needed after stylix
        packages = with pkgs; [
          noto-fonts-cjk-sans # Chinese/Japanese/Korean
        ];
      };
    };
}
