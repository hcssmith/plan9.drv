{pkgs, ...}:let
p9p = "${pkgs.plan9port}/bin/9 9p";
ctl = pkgs.callPackage ../Ctl {};
in pkgs.writeScriptBin "Tags"
''
#!${pkgs.nushell}/bin/nu
	def main [
		-i: int
	] {
		let _winid = ($i | default $env.winid)
		let tags = ("" | append [Run, Build, f] | str join ' ')
		${ctl}/bin/Ctl cleartag
		echo $tags | ${p9p} write $'acme/($_winid)/tag'
	}
''