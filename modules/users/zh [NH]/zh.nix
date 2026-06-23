{ inputs, ... }:
let
  username = "zh";
in
{
  flake.modules.nixos.zh =
    { pkgs, ... }:
    {
      programs.zsh.enable = true;

      users.users.${username} = {
        isNormalUser = true;
        shell = pkgs.zsh;
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
