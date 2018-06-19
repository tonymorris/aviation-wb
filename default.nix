{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  sources = {
    hgeometry = pkgs.fetchFromGitHub {
      owner = "noinia";
      repo = "hgeometry";
      rev = "0.6.0.0";
      sha256 = "00s3hckx04qbywwbh85rq16z3cg2ik6z7vdl9xnkb233lpsczbma";
    };

    vinyl = pkgs.fetchFromGitHub {
      owner = "VinylRecords";
      repo = "vinyl";
      rev = "616e72746f3295db28303b29fe027b4144479070";
      sha256 = "0zm2bsjrgiifggar3w3c6w8hhpkb9rkfqyg4zz3qb5i9d1dd9a36";
    };
  };

  modifiedHaskellPackages = haskellPackages.override {
    overrides = self: super: {
      hgeometry = pkgs.haskell.lib.dontCheck (super.callCabal2nix "hgeometry" "${sources.hgeometry}" {});
      vinyl = super.callCabal2nix "vinyl" "${sources.vinyl}" {};
      Frames = self.callHackage "Frames" "0.1.9" {};
      singletons = pkgs.haskell.lib.dontCheck (self.callHackage "singletons" "2.1" {});
      th-desugar = self.callHackage "th-desugar" "1.6" {};
      fixed-vector = self.callHackage "fixed-vector" "0.9.0.0" {};
      semigroupoids = pkgs.haskell.lib.dontCheck (self.callHackage "semigroupoids" "5.2" {});
      linear = pkgs.haskell.lib.dontCheck (self.callHackage "linear" "1.20.6" {});
      diagrams-lib = pkgs.haskell.lib.dontCheck super.diagrams-lib;
    };
  };

  aviation-wb = modifiedHaskellPackages.callPackage ./aviation-wb.nix {};

in

  aviation-wb

