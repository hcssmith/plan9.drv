{pkgs, ...}: pkgs.writeScriptBin "Exec"
''
#!${pkgs.nushell}/bin/nu

# Excute program, redirect all output to +Messages window
def main [
	program:string
	...args:string
] {
	# find if +Messages exists
	GetAllWinIDs
		| from json
		| each {|it|
			if (GetWinData --id $it.id
					| from json
					| get name == "+Messages)}
	# if it does not, create the window.
	# get the id
	# run command, redirect to acme/win/body
}
''