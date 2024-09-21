{pkgs, ...}: let
gaw = pkgs.callPackage ../GetAllWinIDs {};
t = pkgs.callPackage ../Tags+ {};
getallids = "${gaw}/bin/GetAllWinIDs";
tags = "${t}/bin/Tags+";
in pkgs.writeScriptBin "TagsAll"
''
#!${pkgs.nushell}/bin/nu

# Run Tags+ for all winids
def main [] {
	${getallids}
	| from json
	| each {|it| ${tags} --id $it.id}
	| ignore
}
''