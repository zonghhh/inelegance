# modules/users/cope/configuration.nix
#
# Defines the cope-user NixOS module: creates the system user account
# and links the home-manager configuration.
# Keyed as "cope-user" (not "cope") to avoid colliding with the host
# module also keyed as "cope" in flake.modules.nixos.
{ inputs, ... }: {
  flake.modules.nixos.cope-user = { config, ... }: {
    users.users.${config.var.username} = {
      isNormalUser = true;
      extraGroups  = [ "wheel" "networkmanager" "video" "audio" "input" ];
      initialPassword = "changeme";
    };

    # Wire home-manager to this user, importing the homeManager module by name.
    # inputs.self.modules.homeManager.cope is the accumulated HM module from
    # all files in modules/users/cope/ that set flake.modules.homeManager.cope.
    home-manager.users.${config.var.username} = {
      imports = [ inputs.self.modules.homeManager.cope ];
    };
  };
}
