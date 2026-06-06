{ ... }: {
  # Hyprland Lua is still recent, we do it like this and wait for better alternative.
  flake.modules.homeManager.hyprland.wayland.windowManager.hyprland.extraConfig = /* lua */ ''
    local mod = "SUPER"

    hl.bind(mod .. " + Return", hl.dsp.exec_cmd("ghostty"))
  '';
}
