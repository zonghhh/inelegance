{ inputs, ... }: {
  flake.modules.homeManager.shell = {
    imports = with inputs.self.modules.homeManager; [
      zsh
      eza
      starship
    ];

    programs.bash.enable = true;
  };
}
