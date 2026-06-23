{ inputs, ... }: {
  # Cohesive base needed by all nixosConfigurations.
  flake.modules.nixos.system-minimal =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.self.modules.nixos.vars ];

      nix.settings = {
        substituters = [
          # high priority since it's almost always used
          "https://cache.nixos.org?priority=10"
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

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

      time.timeZone = config.var.timezone;
      i18n.defaultLocale = config.var.locale;
      console.keyMap = config.var.keyboardLayout;

      networking = {
        hostName = config.var.hostname;
        networkmanager.enable = true;
        firewall.enable = true;
      };

      security.sudo.wheelNeedsPassword = true;

      environment.systemPackages = with pkgs; [
        git
        wget
        curl
        ripgrep
      ];

      system.stateVersion = "25.11";
    };
}
