    # Get acme window data based on window id - returns json
    def main [
    	--id (-i): int # Window id
    ] {
    	let winid = if ($id | is-empty) {$env.winid} else {$id}
    	let tbl = 9 9p read acme/index | parse --regex '(?<ind>[0-9]+)[\s]+(?<tagc>[0-9]+)[\s]+(?<bodyc>[0-9]+)[\s]+(?<directory>[01]).*[\s]+(?<modified>[01])[\s](?<tag>.*+)'
    	let final_tbl = $tbl
    		| update tag { $in | parse "{name} {stdtag}|{tag}"}
    		| flatten --all
    		| update stdtag {$in | str trim}
    		| update tag {$in | str trim}
    		| update ind {$in | into int}
    		| update tagc {$in |into int}
    		| update bodyc {$in | into int}
    		| update directory {if $in == 1 {true} else {false}}
    		| update modified {if $in == 1 {true} else {false}}


     	return ($final_tbl | where ind == $winid | get 0 | to json)
    }

