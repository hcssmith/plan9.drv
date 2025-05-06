{pkgs, util}: util.builders.writeNushellScript {
  	name = "TagsAll";
  	packageMap = with pkgs; [
  	 	{ exe = "GetAllWinIDs"; path = callPackage ../GetAllWinIDs {inherit pkgs util;}; }
  	 	{ exe = "Tags+"; path = callPackage ../Tags+ {inherit pkgs util;}; }
  	];
  	text = builtins.readFile ./tagsall.nu;
  }
