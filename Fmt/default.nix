{pkgs, util}:	util.builders.writeNushellScript {
		name = "Fmt";
		packageMap = with pkgs; [
			{ exe = "Exec"; path = callPackage ../Exec {inherit pkgs util;}; }
			{ exe = "Write"; path = callPackage ../Write {inherit pkgs util;}; }
			{ exe = "GetWinData"; path = callPackage ../GetWinData {inherit pkgs util;}; }
			{ exe = "GetAllWinIDs"; path = callPackage ../GetAllWinIDs {inherit pkgs util;}; }
		];
  text = builtins.readFile ./fmt.nu;
  }
