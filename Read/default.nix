{pkgs, util}: util.builders.writeNushellScript {
	name = "Read";
	packageMap = with pkgs; [
		{exe = "9 "; path = plan9port;}
	];
	text = builtins.readFile ./read.nu;
}