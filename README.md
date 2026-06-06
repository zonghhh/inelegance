This will be incredibly inelegant, i'm rebuilding my entire nixos configuration using flake-parts... Heavy inspiration/copying/fork from/of Doc-Steve and Nixy.

Folder tags: `[N]` NixOS, `[H]` home-manager, `[NH]` both. Cosmetic only — modules resolve by attr name.

## System types (layered)

- `system-minimal` — base. headless.
- `system-default` — minimal + home-manager + firmware.
- `system-desktop` — default + audio/portals/fonts/polkit. Pulled in by a compositor; don't import directly.

## New host needs

type (or a compositor) · `var.{hostname,timezone,locale,keyboardLayout}` · hardware.nix + hardware-configuration.nix · a user · a bootloader.

## Desktop

Two cases: **desktop** (a compositor) or **server** (neither). A compositor bundles
its greeter and shell, so importing e.g. `system-hyprland` gives the whole stack.

- compositor + shell are coupled: `hyprland`+`caelestia`.
- the greeter (`greetd`+`tuigreet`) is compositor-agnostic; it learns what to launch
  via `var.sessionCommand` (declared in `session`, set by the compositor, read by the greeter).

## Hardware-specific (not type-agnostic, import per-host)

- `systemd-boot` — needs UEFI.
- `bluetooth` — needs a BT adapter.

`firmware` lives in `system-default` (applies to ~all real machines).