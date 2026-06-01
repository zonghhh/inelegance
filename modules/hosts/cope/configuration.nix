# modules/hosts/cope/configuration.nix
#
# Declares which system type and features this host uses.
# All assignments to flake.modules.nixos.cope across this directory
# are merged by the deferredModule type — this file is just one slice.
{ inputs, ... }: {
  flake.modules.nixos.cope = {
    imports = with inputs.self.modules.nixos; [
      system-desktop  # pulls in system-default → system-minimal + home-manager
      greeter         # greetd + tuigreet
    ];
  };
}
