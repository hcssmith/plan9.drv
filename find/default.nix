{pkgs, ...}: pkgs.writeShellScriptBin "f"
''
${pkgs.silver-searcher}/bin/ag --nocolor --noheading "$@"
''
