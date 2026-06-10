{ inputs, ... }: {
  # System-wide theming for home-manager modules
  flake.modules.nixos.stylix = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];

    stylix = {
      enable = true;
      polarity = "dark";

      # wallpaper, colour scheme manually defined.
      image = inputs.self + "/assets/wallpapers/wallpaper_girl.jpg";

      # leave pre-login surfaces untouched: the boot console log lines and the tuigreet greeter both render with the Linux console palette.
      targets.console.enable = false;

      # Sumi Ink Wash (Dark) — derived from the attached ink-wash portrait
      # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
      base16Scheme = {
        base00 = "1B1813"; # Default Background — deepest sumi ink
        base01 = "232019"; # Lighter Background (Used for status bars, line number and folding marks)
        base02 = "38332A"; # Selection Background
        base03 = "6E655A"; # Comments, Invisibles, Line Highlighting
        base04 = "A39A88"; # Dark Foreground (Used for status bars)
        base05 = "D8D1BD"; # Default Foreground, Caret, Delimiters, Operators
        base06 = "E7E1CE"; # Light Foreground (Not often used)
        base07 = "EFEAD9"; # Light Background (Not often used)
        base08 = "D9695B"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
        base09 = "D49A6A"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
        base0A = "C7A94E"; # Classes, Markup Bold, Search Text Background
        base0B = "8FAE76"; # Strings, Inherited Class, Markup Code, Diff Inserted
        base0C = "6FA9A4"; # Support, Regular Expressions, Escape Characters, Markup Quotes
        base0D = "7B9BC9"; # Functions, Methods, Attribute IDs, Headings, Accent color
        base0E = "A98BAE"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
        base0F = "BC8270"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
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
