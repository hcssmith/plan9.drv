    # Detect the kind of project in the current directory and build it
    def main [] {
    	GetAllWinIDs --exclude-psuedo-windows
    	| from json
    	| each {|it|
    		let wdata = (GetWinData --id $it.id | from json)
    		if ($wdata.modified == true) and ($wdata.directory == false) {
    			Write --id $it.id ctl put
    		}
    	}
    	| ignore
    	if ('./flake.nix' | path exists) {
    		Exec -d ("." | path expand) nix build .
    		GetAllWinIDs
    			| from json
    			| each {|it|
    				let wdata = (GetWinData --id $it.id | from json )
    					let dir = ("." | path expand)
    					let fixed_dir = if ( $dir| str ends-with "/") {$dir} else { $dir + "/" }
    					let win_name = if ($dir | is-empty) {"+Messages"} else { $fixed_dir + "+Messages"}
    					if $wdata.name == $win_name {
    						let source_hash = (nix flake metadata --json --option warn-dirty false
    							| from json
    							| get path
    							| path basename )
    						let text = (Read --id $it.id body)
    						if ($text | str contains $source_hash) {
    							Do --id $it.id Edit , $'s/($source_hash)/ ./g'
    						}
    						Write --id $it.id ctl clean
    						Write --id $it.id ctl show
    					}
    				} | ignore
    		exit
    	}
    }