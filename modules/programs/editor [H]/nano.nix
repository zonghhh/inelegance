{ ... }: {
  flake.modules.homeManager.nano = {
    programs.nano = {
      enable = true;
      settings = {
        tabsize = 2;
      };
    };
  };
}
