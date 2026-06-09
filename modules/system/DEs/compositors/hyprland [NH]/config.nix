{ ... }: {
  # Hyprland Lua is still recent, we do it like this and wait for better alternative.
  flake.modules.homeManager.hyprland.wayland.windowManager.hyprland.extraConfig = /* lua */ ''
    local mod = "SUPER"

    -- BINDS --
    hl.bind(mod .. " + Return", hl.dsp.exec_cmd("ghostty"))

    -- MONITORS --
    hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

    -- MISC --
    hl.config({
      misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
      },
    })
  '';
}
