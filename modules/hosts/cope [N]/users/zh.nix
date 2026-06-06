{ inputs, ... }: {
  flake.modules.nixos.cope.imports = [ inputs.self.modules.nixos.zh ];
}
