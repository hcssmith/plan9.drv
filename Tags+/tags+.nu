    # clear user tags then write default tags for window type
    	def main [
    		--id (-i): int
    	] {
    		let winid = if ($id | is-empty) {$env.winid} else {$id}

    		echo $winid

    		let windata = (GetWinData --id $winid | from json)

    		let tags = (""
    			| if ($windata.directory == true) {
    				append [Run, Build, f] } else {
    				append [Fmt] }
    			| str join ' ')

    		Write -i $winid ctl cleartag
    		Write -i $winid tag $tags
    	}