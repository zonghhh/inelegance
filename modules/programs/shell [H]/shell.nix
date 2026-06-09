{ ... }: {
  flake.modules.homeManager.shell = {
    programs.zsh.enable = true;
    programs.bash.enable = true;
  };
}
