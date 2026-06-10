{ inputs, ... }: {
  # System-wide theming for home-manager modules
  flake.modules.nixos.stylix = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];

    stylix = {
      enable = true;
      polarity = "light";

      # wallpaper, colour scheme manually defined.
      image = inputs.self + "/assets/wallpapers/wallpaper_girl.png";

      # leave pre-login surfaces untouched: the boot console log lines and the tuigreet greeter both render with the Linux console palette.
      targets.console.enable = false;

      # Sumi Ink Wash — derived from the attached ink-wash portrait (light theme)
      # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
      base16Scheme = {
        base00 = "EFEAD9"; # Default Background — warm rice-paper cream
        base01 = "E7E1CE"; # Lighter Background (Used for status bars, line number and folding marks)
        base02 = "D9D1BC"; # Selection Background
        base03 = "A39A88"; # Comments, Invisibles, Line Highlighting
        base04 = "6E655A"; # Dark Foreground (Used for status bars)
        base05 = "3B362E"; # Default Foreground, Caret, Delimiters, Operators
        base06 = "29251F"; # Light Foreground (Not often used)
        base07 = "1A1712"; # Light Background (Not often used)
        base08 = "B24A3E"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
        base09 = "AE7748"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
        base0A = "97792C"; # Classes, Markup Bold, Search Text Background
        base0B = "5F7A4F"; # Strings, Inherited Class, Markup Code, Diff Inserted
        base0C = "4C7C79"; # Support, Regular Expressions, Escape Characters, Markup Quotes
        base0D = "3C5C86"; # Functions, Methods, Attribute IDs, Headings, Accent color
        base0E = "79587F"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
        base0F = "8A574A"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
      };



      # Fonts (applied system-wide + propagated to HM apps incl. caelestia).
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };

      # Cursor theme.
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };
    };
  };
}
