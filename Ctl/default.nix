{pkgs, ...}: let
	p9p = "${pkgs.plan9port}/bin/9 9p";
in pkgs.writeScriptBin "Ctl"
''
#!${pkgs.nushell}/bin/nu
def main [
	command: string,
	extra?:string,
	-i: int
	] {
	let _winid = ($i | default $env.winid)
	match $command {
		"addr=dot" => "addr=dot",
		"clean" => "clean",
		"dirty" => "dirty",
		"cleartag" => "cleartag",
		"del" => "del",
		"delete" => "delete",
		"dot=addr" => "dot=addr",
		"dump" => "dump $extra",
		"dumpdir" => "dumpdir $extra",
		"get" => "get",
		"font" => "font $extra",
		"limit=addr" => "limit=addr",
		"mark" => "mark",
		"name" => "name $extra",
		"nomark" => "nomark",
		"put" => "put",
		"show" => "show"
	} | ${p9p} write $'acme/($_winid)/ctl'
}
''