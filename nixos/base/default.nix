{ config, lib, ... }:
let
	mylib = import ../../lib/default.nix { inherit lib; };
in
{
	# Auto-import all .nix files and directories in this folder, plus the security subfolder.
	imports = mylib.scanPaths ./. ++ [ (mylib.relativeToRoot "nixos/base/security") ];

	# Place global base-level settings here as needed.
}
