{ inputs, ... }:
let
  username = "zh";
in
{
  flake.modules.homeManager.zh = {
    imports = with inputs.self.modules.homeManager; [
      system-desktop
      ghostty
    ];

    home.username = username;
    home.file."pfp.jpg".source = inputs.self + "/assets/profile.jpg";

    programs.home-manager.enable = true;
  };
}