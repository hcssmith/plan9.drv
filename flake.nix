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
      drv = pkgs:
       let
       	util = import ./util {inherit pkgs;};
       in pkgs.symlinkJoin {
          inherit name;
          paths = with pkgs; [
            (callPackage ./find {inherit pkgs util;})
            (callPackage ./acme {inherit pkgs util;})
            (callPackage ./plumbing {inherit pkgs util;})
            (callPackage ./Build {inherit pkgs util;})
            (callPackage ./Run {inherit pkgs util;})
            (callPackage ./Write {inherit pkgs util;})
            (callPackage ./Tags+ {inherit pkgs util;})
            (callPackage ./TagsAll {inherit pkgs util;})
            (callPackage ./GetWinData {inherit pkgs util;})
            (callPackage ./GetAllWinIDs {inherit pkgs util;})
            (callPackage ./Exec {inherit pkgs util;})
            (callPackage ./Fmt {inherit pkgs util;})
            (callPackage ./Do {inherit pkgs util;})
            (callPackage ./Read {inherit pkgs util;})
            #(callPackage ./Git {inherit pkgs util;})
          ];
        };
    };
}
