{ inputs, ... }:
let
  username = "zh";
in
{
  flake.modules.homeManager.zh = {
    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "25.11";

    programs.bash.enable = true;
    programs.home-manager.enable = true;
  };

  flake.modules.nixos.zh = {
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "input"
      ];
      initialPassword = "changeme";
    };

    home-manager.users.${username}.imports = [ inputs.self.modules.homeManager.zh ];
  };
}
