{pkgs, ...}:
let
	p9p = "${pkgs.plan9port}/bin/9 9p";
in pkgs.writeScriptBin "Write"
''
#!${pkgs.nushell}/bin/nu

# Write data to any writeable acme control file based on the id provided.
def main [
	filename: string, # control file to write to.
	...data: string, # data to write to the file
	--id (-i): int, # id to use defaults to $winid env variable
	--new (-n), # write to new acme window
	--new-line (-N) # Add newline to end of stream
] {
	let winid = if ($id | is-empty) {
		if $new {
			"new"} else {
			$env.winid
		}
	} else {
			$id
	}
	let argdata = if ($data | is-empty) {""} else {$data | str join ' '}
	$argdata | ${p9p} write $'acme/($winid)/($filename)'
	if $new_line {
		echo "\n" | ${p9p} write $'acme/($winid)/($filename)'
	}
}
''