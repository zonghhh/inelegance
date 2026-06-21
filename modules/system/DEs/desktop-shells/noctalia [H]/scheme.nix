{ inputs, ... }: {
  # bridges stylix -> noctalia colours.
  flake.modules.homeManager.noctalia =
    { pkgs, config, osConfig, ... }:
    {
      programs.noctalia.settings = {
        wallpaper.enabled = true;
        theme = {
          source = "wallpaper";
          wallpaper_scheme = "m3-content"; # TODO: try the other generators (vibrant, muted, ...) and see what reads best against this wallpaper
        };
      };

      home.activation.noctaliaWallpaperSync = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        noctalia="${inputs.noctalia.packages.${osConfig.nixpkgs.hostPlatform.system}.default}/bin/noctalia"
        for i in $(seq 1 10); do
          if $DRY_RUN_CMD "$noctalia" msg wallpaper-set "${osConfig.stylix.image}"; then
            break
          fi
          sleep 1
        done
      '';
    };
}
