{ withHoogle ? true
}:
let
  pkgs = import <nixpkgs> {};

  hspkgs = 
    if withHoogle then
      pkgs.haskellPackages.override {
        overrides = new: old: {
          ghc = old.ghc // { withPackages = old.ghc.withHoogle; };

          # package overrides goes here
          #
          # end of package overrides

        };
      }
    else
      pkgs.haskellPackages;
      
  drv = hspkgs.callPackage (import ./default.nix) {

    # parameters to the final derive. normally includes package overrides
    #
    # and of parameters
  };
in
  if pkgs.lib.inNixShell then drv.env else drv
