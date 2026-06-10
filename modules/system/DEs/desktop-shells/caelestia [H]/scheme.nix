{ inputs, ... }: {
  /*
    bridges stylix -> caelestia colours.

    caelestia generates its shell palette with its CLI (`caelestia scheme set`)
    build a patched CLI that ships a `custom/main/dark.txt` scheme whose colours are
    mapped from stylix's base16 palette, then apply it at login.
    We also disable the CLI's *external* app theming so stylix (not caelestia) owns GTK/Qt/terminal/etc.
  */
  flake.modules.homeManager.caelestia =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      colors = config.lib.stylix.colors;

      customSchemeFile = pkgs.writeText "custom-dark.txt" ''
        primary_paletteKeyColor ${colors.base0D}
        secondary_paletteKeyColor ${colors.base04}
        tertiary_paletteKeyColor ${colors.base08}
        neutral_paletteKeyColor ${colors.base03}
        neutral_variant_paletteKeyColor ${colors.base03}
        background ${colors.base00}
        onBackground ${colors.base05}
        surface ${colors.base00}
        surfaceDim ${colors.base00}
        surfaceBright ${colors.base02}
        surfaceContainerLowest ${colors.base01}
        surfaceContainerLow ${colors.base01}
        surfaceContainer ${colors.base01}
        surfaceContainerHigh ${colors.base02}
        surfaceContainerHighest ${colors.base02}
        onSurface ${colors.base05}
        surfaceVariant ${colors.base02}
        onSurfaceVariant ${colors.base04}
        inverseSurface ${colors.base05}
        inverseOnSurface ${colors.base00}
        outline ${colors.base03}
        outlineVariant ${colors.base02}
        shadow ${colors.base00}
        scrim ${colors.base00}
        surfaceTint ${colors.base0D}
        primary ${colors.base0D}
        onPrimary ${colors.base00}
        primaryContainer ${colors.base0D}
        onPrimaryContainer ${colors.base05}
        inversePrimary ${colors.base0D}
        secondary ${colors.base0C}
        onSecondary ${colors.base00}
        secondaryContainer ${colors.base02}
        onSecondaryContainer ${colors.base0C}
        tertiary ${colors.base08}
        onTertiary ${colors.base00}
        tertiaryContainer ${colors.base08}
        onTertiaryContainer ${colors.base00}
        error ${colors.base08}
        onError ${colors.base00}
        errorContainer ${colors.base08}
        onErrorContainer ${colors.base05}
        primaryFixed ${colors.base0D}
        primaryFixedDim ${colors.base0D}
        onPrimaryFixed ${colors.base00}
        onPrimaryFixedVariant ${colors.base00}
        secondaryFixed ${colors.base0C}
        secondaryFixedDim ${colors.base0C}
        onSecondaryFixed ${colors.base00}
        onSecondaryFixedVariant ${colors.base02}
        tertiaryFixed ${colors.base08}
        tertiaryFixedDim ${colors.base08}
        onTertiaryFixed ${colors.base00}
        onTertiaryFixedVariant ${colors.base00}
        term0 ${colors.base00}
        term1 ${colors.base08}
        term2 ${colors.base0B}
        term3 ${colors.base0A}
        term4 ${colors.base0D}
        term5 ${colors.base0E}
        term6 ${colors.base0C}
        term7 ${colors.base05}
        term8 ${colors.base03}
        term9 ${colors.base08}
        term10 ${colors.base0B}
        term11 ${colors.base0A}
        term12 ${colors.base0D}
        term13 ${colors.base0E}
        term14 ${colors.base0C}
        term15 ${colors.base07}
        rosewater ${colors.base06}
        flamingo ${colors.base0F}
        pink ${colors.base0E}
        mauve ${colors.base0D}
        red ${colors.base08}
        maroon ${colors.base08}
        peach ${colors.base09}
        yellow ${colors.base0A}
        green ${colors.base0B}
        teal ${colors.base0C}
        sky ${colors.base0C}
        sapphire ${colors.base0C}
        blue ${colors.base0D}
        lavender ${colors.base0D}
        text ${colors.base05}
        subtext1 ${colors.base04}
        subtext0 ${colors.base03}
        overlay2 ${colors.base03}
        overlay1 ${colors.base03}
        overlay0 ${colors.base02}
        surface2 ${colors.base02}
        surface1 ${colors.base01}
        surface0 ${colors.base01}
        base ${colors.base00}
        mantle ${colors.base00}
        crust ${colors.base00}
        success ${colors.base0B}
        onSuccess ${colors.base00}
        successContainer ${colors.base0B}
        onSuccessContainer ${colors.base05}
      '';

      themedCli = inputs.caelestia-cli.packages.${system}.default.overrideAttrs (old: {
        postUnpack = (old.postUnpack or "") + ''
          mkdir -p $sourceRoot/src/caelestia/data/schemes/custom/main
          cp ${customSchemeFile} $sourceRoot/src/caelestia/data/schemes/custom/main/dark.txt
        '';
      });
    in
    {
      programs.caelestia.cli = {
        # mkForce overrides the plain package set in caelestia.nix.
        package = lib.mkForce themedCli;

        # stylix already themes these; stop the CLI from overwriting them.
        settings.theme = {
          enableGtk = false;
          enableQt = false;
          enableTerm = false;
        };
      };

      # apply the stylix-derived scheme each graphical login, so the shell stays in sync with the rest of the desktop's colours.
      systemd.user.services.caelestia-scheme = {
        Unit = {
          Description = "Apply stylix-derived caelestia colour scheme";
          After = [ "caelestia.service" ];
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${themedCli}/bin/caelestia scheme set --name custom --flavour main --mode dark";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
}
