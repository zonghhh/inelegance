{ ... }: {
  # System-level: registers fish in /etc/shells, enables system package
  # completions, and makes it usable as a login shell.
  flake.modules.nixos.shell = {
    programs.fish.enable = true;
  };

  # User-level shell configuration.
  flake.modules.homeManager.shell = {
    programs.fish.enable = true;
    programs.bash.enable = true;
  };
}
