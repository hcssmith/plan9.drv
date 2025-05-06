{
  pkgs,
  util,
}:
util.builders.writeNushellScript {
  name = "Git";
  pkgsInPath = with pkgs; [
    (callPackage ../Fmt {inherit pkgs util;})
  ];
  text = ''
    def main [] {
    	Fmt
    }
  '';
}
