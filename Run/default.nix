{pkgs, util}: util.builders.writeNushellScript {
  	name = "Run";
  	packageMap = with pkgs; [
  		{ exe = "Exec"; path = callPackage ../Exec {inherit pkgs util;};}
  		{ exe = "Build"; path = callPackage ../Build {inherit pkgs util;};}
  	];
  	text = builtins.readFile ./run.nu;
}