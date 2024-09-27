{pkgs, ...}: let
	e = pkgs.callPackage ../Exec {};
	b = pkgs.callPackage ../Build {};
	exec = "${e}/bin/Exec";
	build = "${b}/bin/Build";
in pkgs.writeScriptBin "Run"
''
#!${pkgs.nushell}/bin/nu
	def main [] {
	${build}
	if ('./flake.nix' | path exists) {
		${exec} nix run .
		exit
	}
}
''
