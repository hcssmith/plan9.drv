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
        acme = pkgs.callPackage ./acme {};
        plumbing = pkgs.callPackage ./plumbing {};
        build = pkgs.callPackage ./Build {};
        tags = pkgs.callPackage ./Tags {};
        ctl = pkgs.callPackage ./Ctl {};
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
            mkdir -p $out/lib
            cp ${f}/bin/f $out/bin/f
            cp ${acme}/bin/acme $out/bin/acme
            cp ${build}/bin/Build $out/bin/Build
            cp ${tags}/bin/Tags $out/bin/Tags
            cp ${ctl}/bin/Ctl $out/bin/Ctl
            cp ${plumbing} $out/lib/plumbing
          '';
        });
    };
}
