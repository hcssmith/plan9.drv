{pkgs, ...}: let
	p9 = "${pkgs.plan9port}/bin/9";
	plan9 = "${pkgs.plan9port}/plan9";
	shell = "${plan9}/bin/rc";
	browser = "firefox";
	font = "CMUTypewriter-Regular";
	size = "22a";
in pkgs.writeShellScriptBin "acme"
''
export SHELL="${shell}"
export acmeshell="${shell}"
export BROWSER=${browser}
export tabstop=2
export TERM=dumb
export PAGER=nobs

${p9} acme -a -f /mnt/font/${font}/${size}/font $@
''