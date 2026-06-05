{ ... }: {
  flake.modules.homeManager.hyprland = { ... }: {
    wayland.windowManager.hyprland.settings = {
      bind         = [ ];
      bindm        = [ ];
      monitor      = [ ];
      windowrulev2 = [ ];
    };
  };
}
