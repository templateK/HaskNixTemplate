{ # here goes additional parameter for release build.
  #
  # end of additional project build parameter.
}:
let
  haskOverrides = pkgs: new: old:
    with pkgs.haskell.lib; {

    # likewise shell.nix, here goes package overrides.
    #
    # end of package overrides.

    project        = new.callPackage ./default.nix {};
    project-static = overrideCabal
      (justStaticExecutables (new.callPackage ./default.nix {}))
      (oldDerivation: {
        configureFlags = [

          # cabal parameters goes here.
          # eg) "--ghc-option=-optl=-static"
          #     "--ghc-option=-optl=-L${pkgs.zlib.static}/lib"
          #
          # end of cabal parameters
        ];
      });
    };

  config = {
    packageOverrides = pkgs: {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskOverrides pkgs;
      };
    };
  };

  drvPkgs = import <nixpkgs> { inherit config; };

in
{ project        = drvPkgs.haskellPackages.project;
  project-static = drvPkgs.haskellPackages.project-static;
}
