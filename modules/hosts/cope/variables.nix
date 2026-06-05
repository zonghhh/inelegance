{ ... }: {
  flake.modules.nixos.cope = { ... }: {
    var = {
      hostname = "cope";
      timezone = "Asia/Singapore";
      locale = "en_GB.UTF-8";
      keyboardLayout = "us";
    };
  };
}
