{pkgs, ...}: let
	p9 = "${pkgs.plan9port}/bin/9";
	plan9 = "${pkgs.plan9port}/plan9";
	shell = "${plan9}/bin/rc";
	browser = "firefox";
	font = "CMUTypewriter-Regular";
in pkgs.writeShellScriptBin "a"
''
export SHELL="${shell}"
export acmeshell="${shell}"
export BROWSER=${browser}
export tabstop=2
export TERM=dumb
export PAGER=nobs

if [ "$(pgrep plumber)" ]; then
	echo plumber is running
else
	echo starting plumber
	${p9} plumber &
	#cat "$acme_plumber_rules" "$PLAN9/plumb/basic" | 9p write plumb/rules
fi

if [ "$(pgrep fontsrv)" ]; then
	echo fontsrv is running
else
	echo starting fontsrv
	${p9} fontsrv &
fi

${p9} acme -a -f /mnt/font/${font}/22a/font "$1"
''