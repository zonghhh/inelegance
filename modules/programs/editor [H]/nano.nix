{ ... }: {
  flake.modules.homeManager.nano = {
    home.file.".config/nano/nanorc".text = ''
      set tabsize 2
    '';
  };
}
