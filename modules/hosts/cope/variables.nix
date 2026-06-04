{ ... }: {
  flake.modules.nixos.cope = { ... }: {
    var = {
      username       = "zh";
      hostname       = "cope";
      timezone       = "Asia/Singapore";
      locale         = "en_GB.UTF-8";
      keyboardLayout = "us";
    };
  };
}
