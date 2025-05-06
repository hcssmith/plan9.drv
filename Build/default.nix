{pkgs, util}: util.builders.writeNushellScript {
  	name = "Build";
  	packageMap = with pkgs; [
  		{ exe = "GetAllWinIDs"; path = callPackage ../GetAllWinIDs {inherit pkgs util;}; }
  		{ exe = "GetWinData"; path = callPackage ../GetWinData {inherit pkgs util;}; }
  		{ exe = "Write"; path = callPackage ../Write {inherit pkgs util;}; }
  		{ exe = "Exec"; path = callPackage ../Exec {inherit pkgs util;};}
  		{ exe = "Do"; path = callPackage ../Do {inherit pkgs util;};}
  		{ exe = "Read"; path = callPackage ../Read {inherit pkgs util;};}
  	];
  	text = builtins.readFile ./build.nu;
  }
