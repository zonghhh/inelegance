{
  config,
  lib,
  ...
}: {
  imports = [
    # TOFIX: Choose your theme here:, I wanna do diff approach for this
    ../../themes/zen.nix
  ];

  config.var = {
    hostname = "lappy";
    username = "zh";
    configDirectory =
      "/home/"
      + config.var.username
      + "/.config/nixos"; # The path of the nixos configuration directory

    keyboardLayout = "us";

    location = "Singapore";
    timeZone = "Asia/Singapore";
    defaultLocale = "en_SG.UTF-8";
    extraLocale = "en_SG.UTF-8";

    git = {
      username = "zonghhh";
      email = "192726425+zonghhh@users.noreply.github.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # DON'T TOUCH THIS
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}