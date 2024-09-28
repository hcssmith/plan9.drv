{pkgs, ...}: let
  p9p = "${pkgs.plan9port}/bin/9 9p";
in
  pkgs.writeScriptBin "GetWinData"
  ''
    #!${pkgs.nushell}/bin/nu

    # Get acme window data based on window id - returns json
    def main [
    	--id (-i): int # Window id
    ] {
    	let winid = if ($id | is-empty) {$env.winid} else {$id}
    	let tbl = (${p9p} read acme/index
     	| parse --regex '([0-9]+)[\s]+([0-9]+)[\s]+([0-9]+)[\s]+([0-9])[\s]+([0-9])\s([\w/\.\(\)\+]+)\s([\w\s]+)\s\|\s([\w\s\/\.]+)\s?'
     	| rename ind tagc bodyc directory modified name stdtag tag
     	| update ind {$in | into int}
     	| update tagc {$in | into int}
     	| update bodyc {$in | into int}
     	| update directory {if $in == "1" {true} else {false}}
     	| update modified {if $in == "1" {true} else {false}}
     	| update name {$in | str trim}
     	| update tag {$in | str trim}
     	)

     	return ($tbl | where ind == $winid | get 0 | to json)
    }
  ''
