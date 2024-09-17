{pkgs, ...}: let
  p9 = "${pkgs.plan9port}/bin/9";
  shell = "${pkgs.plan9port}/plan9/bin/rc";
  browser = "firefox";
  font = "CMUTypewriter-Regular";
  size = "22a";
in
  pkgs.writeScriptBin "acme"
  ''
    #!${pkgs.nushell}/bin/nu
    def main [...args] {
    	with-env {
    		SHELL:${shell},
    		acmeshell:${shell},
    		BROWSER:${browser},
    		tabstop:2,
    		TERM:dumb,
    		PAGER:nobs
    	} {
    		let _args = if ($args | is-empty) {"."} else {$args | str join ' '}
    		${p9} acme -a -f /mnt/font/${font}/${size}/font $_args
    	}
    }
  ''
