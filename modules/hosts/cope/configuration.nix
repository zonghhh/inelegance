{ inputs, ... }: {
  flake.modules.nixos.cope = {
    imports = with inputs.self.modules.nixos; [
      system-desktop  # pulls in system-default → system-minimal + home-manager
      greeter         # greetd + tuigreet
    ];
  };
}
