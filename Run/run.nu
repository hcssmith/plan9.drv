    	def main [] {
    	Build
    	if ('./flake.nix' | path exists) {
    		Exec nix run .
    		exit
    	}
    }