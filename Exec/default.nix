{pkgs, util}: util.builders.writeNushellScript {
  	name = "Exec";
  	packageMap = with pkgs; [
  		{exe = "GetAllWinIDs"; path = callPackage ../GetAllWinIDs {inherit pkgs util;}; }
  		{exe = "GetWinData"; path = callPackage ../GetWinData {inherit pkgs util;};}
  		{exe = "Write"; path = callPackage ../Write {inherit pkgs util;};}
  	];
  	text = ''
    # Excute program, redirect all output to +Messages window
    def --wrapped main [
    	program:string
    	...args:string
    	--dir (-d): string
    ] {
    	# find if +Messages exists
    	mut msg_id = 0
    	let win_name = if ($dir | is-empty) {
    		"+Messages"} else {
    		(if ($dir | str ends-with "/") {$dir} else { $dir + "/" }) + "+Messages"}
    	$msg_id = (GetAllWinIDs
    		| from json
    		| each {|it|
    			if ((GetWinData --id $it.id
    					| from json
    					| get name) == $win_name) {$it.id}
    			} )
    	if ($msg_id | is-empty) {
    		# create new window, set name to
    		let control = "name " + $win_name + "\n"
    		Write -n ctl $control
    		$msg_id = (GetAllWinIDs
    			| from json
    			| each {|it|
    				if ((GetWinData --id $it.id
    					| from json
    					| get name) == $win_name) {$it.id}
    				})
    	}
    	let id = $msg_id

    	^$"($program)" ...$args e+o>| lines | each {|it|
    		Write -N -i ...$id body ($it | str trim) } | ignore
    	Write -i ...$id ctl clean
    	Write -i ...$id ctl show
    	}
  '';
  }
