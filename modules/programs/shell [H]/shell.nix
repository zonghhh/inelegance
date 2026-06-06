{ ... }: {
  flake.modules.homeManager.shell = {
    programs.fish.enable = true;
    programs.bash.enable = true;
  };
}
