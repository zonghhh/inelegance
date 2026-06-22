{ inputs, ... }: {
  flake.modules.homeManager.noctalia =
    { pkgs, config, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      imports = [ inputs.noctalia.homeModules.default ];

      programs.noctalia = {
        enable = true;
        package = inputs.noctalia.packages.${system}.default;

        # autostart as a user service bound to graphical-session.target
        systemd.enable = true;

        settings = {
          general.avatarImage = "${config.home.homeDirectory}/pfp.jpg";
          weather.enabled = true;

          location = {
            auto_locate = true;
            weather = true;
          };
        };
      };
    };
}
