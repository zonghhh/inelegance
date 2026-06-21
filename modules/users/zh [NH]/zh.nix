{ inputs, ... }:
let
  username = "zh";
in
{
  flake.modules.homeManager.zh = {
    imports = with inputs.self.modules.homeManager; [
      shell
      ghostty
      nano
      zen
    ];

    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "25.11";

    # TODO: profile picture. placed in ~/.face for caelestia to access, check if noctalia has a pfp option to use this
    home.file.".face".source = inputs.self + "/assets/profile.jpg";

    programs.home-manager.enable = true;
  };

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
