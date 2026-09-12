This directory contains desktop-level scaffolds and small modules that are intentionally
kept inactive by default. Enable them on a per-host basis by setting the corresponding
options in the host `configuration.nix`.

Examples
--------
Enable `niri` for host `lappy` in `hosts/lappy/configuration.nix`:

services.niri.enable = true;

If you want to use the `niri-flake` input declared in `flake.nix`, add it to the
host `environment.systemPackages` or reference it from `specialArgs` in `flake.nix`.

Greeter
------
The `greeter.nix` scaffold exposes `services.greeter.enable` and `services.greeter.manager`.
Set `services.greeter.manager = "sddm";` to choose the display manager.

Notes
-----
- Keep modules small and focused. Hosts should enable only the pieces they need.
- Avoid enabling compositors globally; prefer per-host toggles to preserve modularity.
