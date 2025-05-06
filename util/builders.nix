{pkgs, ...}: {
  writeNushellScript = {
    name,
    text,
    packageMap ? [],
    variableMap ? [],
  }:let
  	pkgSubstText = (builtins.replaceStrings (map (p: p.exe) packageMap) (map (p: "${p.path}/bin/${p.exe}") packageMap) text);
  	varSubstText = (builtins.replaceStrings (map (p: p.var) variableMap) (map (p: p.val) variableMap) pkgSubstText);
  in pkgs.writeScriptBin "${name}" (builtins.concatStringsSep "\n" (pkgs.lib.flatten [
      "#!${pkgs.nushell}/bin/nu"
      "${varSubstText}"
    ]));
}
