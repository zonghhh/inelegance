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

          "${mod}+N".action.spawn = noctalia "panel-toggle control-center";
          "${mod}+D".action.spawn = noctalia "window-switcher";

          # Windows
          "${mod}+Q".action = close-window;
          "${mod}+F".action = maximize-column; # maximises the window
          "${mod}+Shift+F".action = fullscreen-window; # fullscreen
          "${mod}+V".action = toggle-window-floating;
          "${mod}+Shift+H".action = reset-window-height;

          # mouse
          # niri binds Mod+LeftClick (move) and Mod+RightClick (resize)
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

        # MISC
        prefer-no-csd = true;
        layout = {
          gaps = 8;
          border = {
            enable = true;
            width = 2;
            active.color = "#${config.lib.stylix.colors.base0D}";
            inactive.color = "transparent"; # niri's csscolorparser accepts named colors
          };
        };

        hotkey-overlay.skip-at-startup = true;
      };
    };
}
