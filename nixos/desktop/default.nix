{ pkgs, inputs, lib, ... }:
let
	mylib = import ../../lib/default.nix { inherit lib; };
in
{
	imports = [
		../base
		# Desktop-level scaffolds (per-host enablement)
		./niri.nix
		./noctalia.nix
		./greeter.nix
	] ++ mylib.scanPaths ./damentals;

	# Desktop tools & polkit
	security.polkit.enable = true;
	programs.dconf.enable = true;

	# Fonts
	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-color-emoji
	];
}
