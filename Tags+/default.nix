{pkgs, ...}:let
p9p = "${pkgs.plan9port}/bin/9 9p";
w = pkgs.callPackage ../Write {};
gwd = pkgs.callPackage ../GetWinData {};
write = "${w}/bin/Write";
getwindata = "${gwd}/bin/GetWinData";
in pkgs.writeScriptBin "Tags+"
''
#!${pkgs.nushell}/bin/nu

# clear user tags then write default tags for window type
	def main [
		--id (-i): int
	] {
		let winid = if ($id | is-empty) {$env.winid} else {$id}

		echo $winid

		let windata = (${getwindata} --id $winid | from json)

		let tags = (""
			| if ($windata.directory == true) {
				append [Run, Build, f] } else {
				append [Fmt] }
			| str join ' ')

		${write} -i $winid ctl cleartag
		${write} -i $winid tag $tags
	}
''