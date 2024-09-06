{pkgs, ...}: pkgs.writeText "plumbing" (builtins.concatStringsSep "\n" [
	(builtins.readFile "${pkgs.plan9port}/plan9/plumb/initial.plumbing")
	(builtins.readFile "${pkgs.plan9port}/plan9/plumb/fileaddr")
	(builtins.readFile "${pkgs.plan9port}/plan9/plumb/basic")
	(builtins.readFile ./github.plumb)
])