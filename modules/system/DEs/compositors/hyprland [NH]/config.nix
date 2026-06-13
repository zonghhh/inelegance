{ ... }: {
  # TODO: Hyprland Lua is still recent, we do it like this and wait for better alternative.
  flake.modules.homeManager.hyprland.wayland.windowManager.hyprland.extraConfig = /* lua */ ''
    local mod = "SUPER"
    local shiftMod = mod .. " + SHIFT"

    -- BINDS --

    -- Quick-Launch --
    hl.bind(mod .. " + Return", hl.dsp.exec_cmd("ghostty"))
    hl.bind(mod .. " + SPACE", hl.dsp.global("caelestia:launcher")) -- Launcher
    hl.bind(mod .. " + X", hl.dsp.global("caelestia:session")) -- Powermenu
    hl.bind(mod .. " + N", hl.dsp.exec_cmd("caelestia shell drawers toggle sidebar")) -- Sidebar (notifications, quick actions)
    hl.bind(mod .. " + D", hl.dsp.exec_cmd("caelestia shell drawers toggle dashboard")) -- Dashboard

    -- Windows --
    hl.bind(mod .. " + Q", hl.dsp.window.close())
    hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
    hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" })) -- Toggle floating

    -- mouse
    hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- Move window
    hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Resize window

    -- Focus Windows --
    hl.bind(mod .. " + Left", hl.dsp.focus({ direction = "left" }))
    hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "down" }))
    hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "up" }))
    hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "right" }))
    hl.bind(shiftMod .. " + J", hl.dsp.layout("removemaster")) -- TOFIX: Remove from master
    hl.bind(shiftMod .. " + K", hl.dsp.layout("addmaster")) -- TOFIX: Add to master

    -- Workspaces --
    hl.bind(mod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))
    for i = 1, 9 do
      hl.bind(mod .. " + code:1" .. (i - 1), hl.dsp.focus({ workspace = i })) -- Switch to workspace
      hl.bind(shiftMod .. " + code:1" .. (i - 1), hl.dsp.window.move({ workspace = i })) -- Move window to workspace
    end

    -- Utilities --
    hl.bind(shiftMod .. " + S", hl.dsp.global("caelestia:screenshotFreeze")) -- Capture region (freeze)

    -- Locked Binds --
    -- brightness
    hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), { locked = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), { locked = true })

    -- sound
    hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })


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
