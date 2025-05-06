{pkgs, util}: util.builders.writeNushellScript {
  	name = "GetWinData";
  	packageMap = [
  		{ exe = "9 "; path = pkgs.plan9port; }
  	];
  	text = builtins.readFile ./getwindata.nu;
  }