{pkgs, ...}: let
  e = pkgs.callPackage ../Exec {};
  w = pkgs.callPackage ../Write {};
  gwd = pkgs.callPackage ../GetWinData {};
  gad = pkgs.callPackage ../GetAllWinIDs {};
  exec = "${e}/bin/Exec";
  write = "${w}/bin/Write";
  getwindata = "${gwd}/bin/GetWinData";
  getallwinids = "${gad}/bin/GetAllWinIDs";
in
  pkgs.writeScriptBin "Fmt" ''
    #!${pkgs.nushell}/bin/nu

    #Run the formatter on the current file.
    def main [] {
    	let id = $env.winid
    	let windata = (${getwindata} --id $id | from json)
    	${write} --id $id ctl put
    	match $windata {
    		{directory: true, name: $name} if ($name | str trim | append 'flake.nix' | str join "" | path exists) => {
    			${exec} nix fmt .
    			${getallwinids} -e | from json | each {|it| ${write} --id $it.id ctl get} | ignore
    		},
    		{directory: false, name: $name} if ($name | path basename | str ends-with '.nix') => {
    			${exec} nix fmt $name
    			${write} --id $id ctl get
    		},
    		_ => exit
    	}
    }
  ''
