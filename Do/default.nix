{pkgs, util}: util.builders.writeNushellScript {
	name = "Do";
	packageMap = with pkgs; [
		{	exe = "Write"; path = callPackage ../Write {inherit pkgs util;}; }
		{ exe = "GetWinData"; path = callPackage ../GetWinData {inherit pkgs util;}; }
		{ exe = "9 "; path = plan9port; }
	];
	text = builtins.readFile ./do.nu;
}