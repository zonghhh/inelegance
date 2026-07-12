{ inputs, ... }: {
  # A compositor aspect — orthogonal to system-desktop. A desktop host composes
  # both (see hosts/cope). Bundles its greeter (session interface) and shell.
  flake.modules.nixos.niri = { pkgs, ... }: {
    imports = with inputs.self.modules.nixos; [
      session
      greeter
    ];

    # https://github.com/sodiboo/niri-flake/blob/main/README.md
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    nix.settings = {
      extra-substituters = [ 
        "https://noctalia.cachix.org"
        "https://niri-epireyn.cachix.org"
      ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
      ];
    };

    # Tell the bundled greeter how to launch this compositor.
    var.sessionCommand = "niri-session";

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      niri
      noctalia
    ];
  };

  flake.modules.homeManager.niri = {
    imports = [ inputs.niri.homeModules.niri ];
  };
}
