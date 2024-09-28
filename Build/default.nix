{pkgs, ...}: let
  gaw = pkgs.callPackage ../GetAllWinIDs {};
  gwd = pkgs.callPackage ../GetWinData {};
  w = pkgs.callPackage ../Write {};
  e = pkgs.callPackage ../Exec {};
  getallids = "${gaw}/bin/GetAllWinIDs";
  getwindata = "${gwd}/bin/GetWinData";
  write = "${w}/bin/Write";
  exec = "${e}/bin/Exec";
in
  pkgs.writeScriptBin "Build"
  ''
    #!${pkgs.nushell}/bin/nu

    # Detect the kind of project in the current directory and build it
    def main [] {
    	${getallids} --exclude-psuedo-windows
    	| from json
    	| each {|it|
    		let wdata = (${getwindata} --id $it.id | from json)
    		if ($wdata.modified == true) and ($wdata.directory == false) {
    			${write} --id $it.id ctl put
    		}
    	}
    	| ignore
    	if ('./flake.nix' | path exists) {
    		${exec} nix build .
    		exit
    	}
    }
  ''
