{pkgs, util}: util.builders.writeNushellScript {
  	name = "Tags+";
  	packageMap = with pkgs; [
  		{ exe = "Write"; path = callPackage ../Write {inherit pkgs util;}; }
			{ exe = "GetWinData"; path = callPackage ../GetWinData {inherit pkgs util;}; }
  	];
  text = builtins.readFile ./tags+.nu;
  }
