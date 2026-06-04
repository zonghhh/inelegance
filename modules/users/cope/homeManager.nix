{ ... }: {
  flake.modules.homeManager.cope = { ... }: {
    home.username      = "zh";
    home.homeDirectory = "/home/zh";
    home.stateVersion  = "25.11";

    programs.bash.enable         = true;
    programs.home-manager.enable = true;
  };
}
