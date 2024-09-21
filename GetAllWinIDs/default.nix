{pkgs, ...}: let
	p9p = "${pkgs.plan9port}/bin/9 9p";
	gwd = pkgs.callPackage ../GetWinData {};
	getwindata = "${gwd}/bin/GetWinData";
in pkgs.writeScriptBin "GetAllWinIDs"
''
#!${pkgs.nushell}/bin/nu

# Get all window IDs returns json
def main [
 --exclude-psuedo-windows (-e) # Exclude any psuedo windos from list
] {
	let ids = (${p9p} read acme/index
		| parse --regex '([0-9]+)[\s].*$'
		| rename id
		| update id {$in | into int}
		)
	if $exclude_psuedo_windows {
		return ($ids | each {|it|
			let name = ${getwindata} --id $it.id | from json | get name | str trim
			if ($name | str ends-with '+Errors') or ($name | str ends-with '+Messages') {null} else {$it}
		} | to json)
		} else {
		return ($ids | to json)
		}
}
''