{
  description = ''Inelegant setup, but it works.'';

  inputs = {
    # damentals
    nixpkgs.url = "github:nixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixOS/nixpkgs/nixos-26.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/v1.13.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    preservation.url = "github:nix-community/preservation";
    stylix.url = "github:danth/stylix";

    # tracked software packages
    zen-browser-flake.url = "github:0xc000022070/zen-browser-flake";
    noctalia.url = "github:noctalia-dev/noctalia";
    niri-flake = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # extra stuff
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations = {
      lappy =
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./overlays
            ./hosts/lappy/configuration.nix
            
            inputs.sops-nix.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            inputs.disko.nixosModules.default
            inputs.lanzaboote.nixosModules.lanzaboote
            inputs.preservation.nixosModules.preservation # TODO: check attr names looks like default would just map to preservation
            inputs.stylix.nixosModules.stylix

            inputs.noctalia.nixosModules.default
            inputs.niri-flake.nixosModules.niri

            # hardware-specific modules
            inputs.nixos-hardware.nixosModules.common-cpu-amd-default
          ];
        };
    };
  };
}