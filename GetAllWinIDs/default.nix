{pkgs, util}: util.builders.writeNushellScript {
  	name = "GetAllWinIDs";
  	packageMap = [
  		{ exe = "GetWinData"; path = pkgs.callPackage ../GetWinData {inherit pkgs util;};}
  		{ exe = "9 "; path = pkgs.plan9port; }
  	];

  text = ''
    # Get all window IDs returns json
    def main [
     --exclude-psuedo-windows (-e) # Exclude any psuedo windos from list
    ] {
    	let ids = (9 9p read acme/index
    		| parse --regex '([0-9]+)[\s].*$'
    		| rename id
    		| update id {$in | into int}
    		)
    	if $exclude_psuedo_windows {
    		return ($ids | each {|it|
    			let name = GetWinData --id $it.id | from json | get name | str trim
    			if ($name | path basename | str starts-with '+') {null} else {$it}
    		} | to json)
    		} else {
    		return ($ids | to json)
    		}
    }
  '';
 }
