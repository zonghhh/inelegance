{ inputs, ... }: {
  flake.modules.nixos.system-desktop = { pkgs, ... }: {
    imports = with inputs.self.modules.nixos; [
      system-default
    ];

    programs.hyprland = {
      enable        = true;
      withUWSM      = true;
      package       = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    programs.uwsm.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
      enable            = true;
      alsa.enable       = true;
      alsa.support32Bit = true;
      pulse.enable      = true;
      jack.enable       = true;
    };

    xdg.portal = {
      enable        = true;
      extraPortals  = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
      ];
    };

    services.dbus.enable   = true;
    security.polkit.enable = true;

    environment = {
      systemPackages   = with pkgs; [ brightnessctl playerctl wl-clipboard libnotify ];
      sessionVariables = {
        NIXOS_OZONE_WL   = "1";
        XDG_SESSION_TYPE = "wayland";
      };
    };
  };
}
