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
      drv = pkgs: pkgs.symlinkJoin {
      		inherit name;
      		paths = with pkgs; [
      			(callPackage ./find {})
      			(callPackage ./acme {})
      			(callPackage ./plumbing {})
      			(callPackage ./Build {})
      			(callPackage ./Run {})
      			(callPackage ./Write {})
      			(callPackage ./Tags+ {})
      			(callPackage ./TagsAll {})
      			(callPackage ./GetWinData {})
      			(callPackage ./GetAllWinIDs {})
      			(callPackage ./Exec {})
      			(callPackage ./Fmt {})
      		];
      	};
    };
}
