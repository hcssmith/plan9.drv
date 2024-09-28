{pkgs, ...}:
pkgs.writeTextFile {
  name = "plumbing";
  text = builtins.concatStringsSep "\n" [
    (builtins.readFile "${pkgs.plan9port}/plan9/plumb/initial.plumbing")
    (builtins.readFile "${pkgs.plan9port}/plan9/plumb/fileaddr")
    (builtins.readFile "${pkgs.plan9port}/plan9/plumb/basic")
    (builtins.readFile ./github.plumb)
  ];
  destination = "/lib/plumbing";
}
