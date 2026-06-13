This will be incredibly inelegant, i'm rebuilding my entire nixos configuration using flake-parts... heavy inspiration/copying/fork from/of Doc-Steve and Nixy.

Folder naming: `[N]` NixOS, `[H]` home-manager, `[NH]` both.

## System types (layered)

- `system-minimal` — base. headless.
- `system-default` — minimal + home-manager + firmware.
- `system-desktop` — default + audio/portals/fonts/polkit

## New host needs

system-*, `var.{hostname,timezone,locale,keyboardLayout}`, hardware.nix + hardware-configuration.nix, a user, a bootloader, DE if desktop. <br>
For laptop:<br>
```services.upower.enable = true;```<br>
```services.power-profiles-daemon.enable = true;```

## Hardware-specific (not type-agnostic, import per-host)

- `systemd-boot` — needs UEFI.
- `bluetooth` — needs a BT adapter.

`firmware` lives in `system-default` (applies to ~all real machines).

## Usage
if new inputs:
```nix run .#write-flake```

for update:<br>
```nix flake update```<br>
```sudo nixos-rebuild switch .#hostname -vL``` (-vL; verbose and print build logs)

## Additional documenting
(TODO:) to-do...yes<br>
(TOFIX:) i will fix it, someday...depends on if i really need it ahaha<br>
(NOTE:) some things of note, yes i know it is a bad label...T_T