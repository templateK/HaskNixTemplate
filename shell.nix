{ withHoogle ? true
}:
let
  pkgs = import <nixpkgs> {};

  hspkgs = pkgs.haskellPackages.override {
    overrides = new: old: {

      # package overrides goes here
      #
      # end of package overrides

      ghc = if withHoogle
              then old.ghc // { withPackages = old.ghc.withHoogle; }
              else old.ghc;
    };
  };
      
  drv = hspkgs.callPackage (import ./default.nix) {

    # parameters to the final derive. normally includes package overrides
    #
    # and of parameters
  };
in
  if pkgs.lib.inNixShell then drv.env else drv
