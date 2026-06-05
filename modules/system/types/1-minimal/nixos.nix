{ ... }: {
  flake.modules.nixos.system-minimal =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {

      options.var = {
        hostname = lib.mkOption { type = lib.types.str; };
        timezone = lib.mkOption {
          type = lib.types.str;
          default = "UTC";
        };
        locale = lib.mkOption {
          type = lib.types.str;
          default = "en_US.UTF-8";
        };
        keyboardLayout = lib.mkOption {
          type = lib.types.str;
          default = "us";
        };
      };

      config = {
        nix.settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          auto-optimise-store = true;
          trusted-users = [
            "root"
            "@wheel"
          ];
        };
        nix.gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 14d";
        };

        nixpkgs.config.allowUnfree = true;

        time.timeZone = config.var.timezone;
        i18n.defaultLocale = config.var.locale;
        console.keyMap = config.var.keyboardLayout;

        boot.loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        networking = {
          hostName = config.var.hostname;
          networkmanager.enable = true;
          firewall.enable = true;
        };

        security.sudo.wheelNeedsPassword = false;

        environment.systemPackages = with pkgs; [
          git
          wget
          curl
          ripgrep
        ];

        system.stateVersion = "25.11";
      };
    };
}
