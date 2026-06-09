{ ... }: {
  flake.modules.homeManager.nano = {
    programs.nano = {
      enable = true;
      settings = {
        tabsize = 2;
        # tabstospaces = true; # uncomment to insert spaces instead of a tab char
      };
    };
  };
}
