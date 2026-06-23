{ ... }: {
  flake.modules.nixos.cope = { ... }: {
    var = {
      hostname = "cope";
      timezone = "Asia/Singapore";
      locale = "en_GB.UTF-8";
      keyboardLayout = "us";
      weatherLocation = "Singapore"; # not a nixos config option, but used by the weather module
    };
  };
}
