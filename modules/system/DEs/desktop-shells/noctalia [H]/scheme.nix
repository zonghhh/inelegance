{ inputs, ... }: {
  # bridges stylix -> noctalia colours.
  flake.modules.homeManager.noctalia =
    { pkgs, osConfig, ... }:
    {
      programs.noctalia.settings = {
        wallpaper.enabled = false;
        theme = {
          source = "wallpaper";
          wallpaper_scheme = "m3-content"; # TODO: try the other generators (vibrant, muted, ...) and see what reads best against this wallpaper
        };
      };

      systemd.user.services.noctalia-wallpaper-sync = {
        Unit = {
          Description = "Point noctalia's colour extraction at the stylix wallpaper";
          After = [ "noctalia.service" ];
          Requires = [ "noctalia.service" ];
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "noctalia-wallpaper-sync" ''
            noctalia="${inputs.noctalia.packages.${osConfig.nixpkgs.hostPlatform.system}.default}/bin/noctalia"
            for i in $(seq 1 10); do
              if "$noctalia" msg wallpaper-set "${osConfig.stylix.image}"; then
                exit 0
              fi
              sleep 1
            done
            echo "noctalia-wallpaper-sync: gave up waiting for noctalia's IPC handler" >&2
            exit 1
          '';
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
}
