{pkgs, ...}:
pkgs.writeShellScriptBin "Build"
''
if [ -e ./flake.nix ]; then
	nix build
	exit
fi
''
