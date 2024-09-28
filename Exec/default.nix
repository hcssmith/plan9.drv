{pkgs, ...}: let
  gaw = pkgs.callPackage ../GetAllWinIDs {};
  gwd = pkgs.callPackage ../GetWinData {};
  w = pkgs.callPackage ../Write {};
  getallwinids = "${gaw}/bin/GetAllWinIDs";
  getwindata = "${gwd}/bin/GetWinData";
  write = "${w}/bin/Write";
  p9p = "${pkgs.plan9port}/bin/9 9p";
in
  pkgs.writeScriptBin "Exec"
  ''
    #!${pkgs.nushell}/bin/nu

    # Excute program, redirect all output to +Messages window
    def --wrapped main [
    	program:string
    	...args:string
    ] {
    	# find if +Messages exists
    	mut msg_id = 0
    	$msg_id = (${getallwinids}
    		| from json
    		| each {|it|
    			if ((${getwindata} --id $it.id
    					| from json
    					| get name) == "+Messages") {$it.id}
    			} )
    	if ($msg_id | is-empty) {
    		# create new window, set name to
    		${write} -n ctl "name +Messages\n"
    		$msg_id = (${getallwinids}
    			| from json
    			| each {|it|
    				if ((${getwindata} --id $it.id
    					| from json
    					| get name) == "+Messages") {$it.id}
    				})
    	}
    	let id = $msg_id

    	let cmd = ($'($program) ' | append ($args | str join ' ') | str join ' ')

    	^$"($program)" ...$args e+o>| each {|it| ${write} -i ...$id body $it} | ignore
    	${write} -i ...$id ctl clean
    	${write} -i ...$id ctl show
    	}
  ''
