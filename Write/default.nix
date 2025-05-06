{pkgs, util}: util.builders.writeNushellScript {
  	name = "Write";
  	packageMap = [
  		{ exe = "9 "; path = pkgs.plan9port;}
  	];
  text = builtins.readFile ./write.nu;
  }
