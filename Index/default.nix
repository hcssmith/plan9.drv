{pkgs, ...}: let
	p9p = "${pkgs.plan9port}/bin/9 9p";
in pkgs.writeScriptBin "Index"
''
#!${pkgs.nushell}/bin/nu
def main [] {
 let tbl = (${p9p} read acme/index
 	| parse --regex '([0-9]+)[\s]+([0-9]+)[\s]+([0-9]+)[\s]+([0-9])[\s]+([0-9])\s([\w/\.\(\)\+]+)\s([\w\s]+)\s\|\s([\w\s\/\.]+)\s'
 	| rename ind tagc bodyc directory modified name stdtag tag
 	| to json
 	)
	return $tbl
}
''