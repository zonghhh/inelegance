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

      security.sudo.wheelNeedsPassword = false;

      environment.systemPackages = with pkgs; [
        git
        wget
        curl
        ripgrep
      ];

      system.stateVersion = "25.11";
    };
}
