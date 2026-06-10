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
    ];

    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "25.11";

    # Profile picture. ~/.face is the per-user avatar convention; caelestia (and
    # other avatar-aware apps) read it from the logged-in user's home.
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
