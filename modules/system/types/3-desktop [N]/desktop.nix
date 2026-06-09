{ inputs, ... }: {
  flake.modules.nixos.system-desktop =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        system-default
        audio
        fonts
        stylix
      ];

      # Core wayland desktop plumbing.
      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common.default = "*";
      };

      services.dbus.enable = true;
      security.polkit.enable = true;

      environment = {
        systemPackages = with pkgs; [
          brightnessctl
          playerctl
          wl-clipboard
          libnotify
        ];
        sessionVariables = {
          NIXOS_OZONE_WL = "1";
          XDG_SESSION_TYPE = "wayland";
        };
      };
    };
}
