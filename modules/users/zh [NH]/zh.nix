{ inputs, ... }:
let
  username = "zh";
in
{
  flake.modules.homeManager.zh = {
    imports = with inputs.self.modules.homeManager; [
      shell
      ghostty
    ];

    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "25.11";

    programs.home-manager.enable = true;
  };

  flake.modules.nixos.zh =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        shell
      ];

      users.users.${username} = {
        isNormalUser = true;
        shell = pkgs.fish;
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
