{ ... }: {
  # Keybinds and settings for Niri, the compositor used in this DE.
  flake.modules.homeManager.niri =
    { config, ... }:
    let
      mod = "Mod";
      noctalia = cmd: [
        "noctalia"
        "msg"
        cmd
      ];
    in
    {
      programs.niri.settings = {
        binds = with config.lib.niri.actions; {
          # Quick-Launch
          "${mod}+Return".action.spawn = [ "ghostty" ];
          "${mod}+Space".action.spawn = noctalia "panel-toggle launcher";
          "${mod}+X".action.spawn = noctalia "panel-toggle session";

          # NOTE: Hyprland's sidebar (notifications/quick-actions) and
          # dashboard binds don't have distinct v5 equivalents — noctalia
          # v5's panel set is launcher / session / clipboard / wallpaper /
          # control-center, no separate "notifications" or "dashboard"
          # panel. Picked the two closest-but-different options below so
          # both keys do something useful; swap either for whichever of
          # these you actually want once you've used the shell a bit:
          #   - control-center  -> quick settings, audio/network/etc
          #   - window-switcher -> Alt+Tab-style grid of open windows
          #   - clipboard       -> clipboard history panel
          "${mod}+N".action.spawn = noctalia "panel-toggle control-center";
          "${mod}+D".action.spawn = noctalia "window-switcher";

          # Windows
          "${mod}+Q".action = close-window;
          "${mod}+F".action = fullscreen-window;
          "${mod}+V".action = toggle-window-floating;

          # mouse
          # NOTE: Niri binds Mod+LeftClick (move) and Mod+RightClick (resize)
          # as built-in input behaviour, not as `binds` entries

          # Focus Windows
          "${mod}+Left".action = focus-column-left;
          "${mod}+Down".action = focus-window-down;
          "${mod}+Up".action = focus-window-up;
          "${mod}+Right".action = focus-column-right;

          # Workspaces
          "${mod}+Tab".action = focus-workspace-down;
          "${mod}+1".action = focus-workspace 1;
          "${mod}+2".action = focus-workspace 2;
          "${mod}+3".action = focus-workspace 3;
          "${mod}+4".action = focus-workspace 4;
          "${mod}+5".action = focus-workspace 5;
          "${mod}+6".action = focus-workspace 6;
          "${mod}+7".action = focus-workspace 7;
          "${mod}+8".action = focus-workspace 8;
          "${mod}+9".action = focus-workspace 9;
          "${mod}+Shift+1".action.move-column-to-workspace = [ 1 ];
          "${mod}+Shift+2".action.move-column-to-workspace = [ 2 ];
          "${mod}+Shift+3".action.move-column-to-workspace = [ 3 ];
          "${mod}+Shift+4".action.move-column-to-workspace = [ 4 ];
          "${mod}+Shift+5".action.move-column-to-workspace = [ 5 ];
          "${mod}+Shift+6".action.move-column-to-workspace = [ 6 ];
          "${mod}+Shift+7".action.move-column-to-workspace = [ 7 ];
          "${mod}+Shift+8".action.move-column-to-workspace = [ 8 ];
          "${mod}+Shift+9".action.move-column-to-workspace = [ 9 ];

          # Utilities
          # NOTE: Noctalia's screenshot plugin is Hyprland-only — on Niri the
          # docs say to use the compositor's own built-in screenshot tool,
          # so this binds straight to niri's interactive screenshot action
          # rather than a noctalia-shell ipc call.
          "${mod}+Shift+S".action.screenshot = [ ];

          # Locked Binds — brightness
          "XF86MonBrightnessUp" = {
            allow-when-locked = true;
            action.spawn = noctalia "brightness-up";
          };
          "XF86MonBrightnessDown" = {
            allow-when-locked = true;
            action.spawn = noctalia "brightness-down";
          };

          # Locked Binds — sound
          "XF86AudioMute" = {
            allow-when-locked = true;
            action.spawn = noctalia "volume-mute";
          };
          "XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action.spawn = noctalia "volume-up";
          };
          "XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action.spawn = noctalia "volume-down";
          };
        };

        # MISC — Niri's nearest equivalents to the hyprland general/decoration/misc block
        prefer-no-csd = true;
        layout = {
          gaps = 8; # TODO: tune to taste, hyprland config had no explicit gap value
          border = {
            enable = true;
            width = 2;
            active.color = "#${config.lib.stylix.colors.base0D}";
            inactive.color = "transparent"; # niri's csscolorparser accepts named colors
          };
          # TOFIX: Niri has no per-window opacity/rounding option in settings.nix
          # as of writing (rounding ~ geometry-corner-radius is a window-rule,
          # not a global layout knob); window rules can target app-ids if needed.
        };

        hotkey-overlay.skip-at-startup = true; # closest analogue to disable_hyprland_logo/splash
      };
    };
}
