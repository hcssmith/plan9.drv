{
  description = "Plan 9 - Usefull scripts";
  inputs = {
    flake-lib = {
      url = "github:hcssmith/flake-lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = {
    self,
    flake-lib,
    ...
  }:
    flake-lib.lib.mkApp rec {
      inherit self;
      name = "plan9";
      drv = pkgs: let
        f = pkgs.callPackage ./find {};
        a = pkgs.callPackage ./acme {};
      in
        pkgs.stdenv.mkDerivation (fAttrs: {
          pname = name;
          version = "master";
          buildInputs = with pkgs; [
            plan9port
            silver-searcher
          ];
          src = ./.;
          installPhase = ''
            mkdir -p $out/bin
            cp ${f}/bin/f $out/bin/f
            cp ${a}/bin/a $out/bin/a
          '';
        });
    };
}
