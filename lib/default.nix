{ lib, ... }:
{
  # Return helpers used to discover and import module files relative to the repo.
  relativeToRoot = lib.path.append ../.;

  scanPaths = path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          p: _type:
          (_type == "directory")
          || (
            (p != "default.nix")
            && (lib.strings.hasSuffix ".nix" p)
          )
        ) (builtins.readDir path)
      )
    );
}
