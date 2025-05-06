{pkgs, util}: let
  p9 = "${pkgs.plan9port}/bin/9";
  shell = "${pkgs.plan9port}/plan9/bin/rc";
  browser = "firefox";
  font = "CMUTypewriter-Regular";
  size = "20a";
in
	util.builders.writeNushellScript {
		name = "acme";
		packageMap = [
			{exe = "9"; path = pkgs.plan9port;}
		];
		variableMap = [
			{ var = "_SHELL_"; val = "${pkgs.plan9port}/plan9/bin/rc"; }
			{ var = "_BROWSER_"; val = "${pkgs.firefox}/bin/firefox"; }
			{ var = "_FONT_"; val = "CMUTypewriter-Regular"; }
			{ var = "_SIZE_"; val = "20a"; }
		];
		text = builtins.readFile ./acme.nu;
  }