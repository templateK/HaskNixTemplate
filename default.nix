{ mkDerivation, base, stdenv, vector }:
mkDerivation {
  pname = "HaskNixTemplate";
  version = "0.0.0.1";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base vector ];
  homepage = "https://github.com/frostyrock/HaskNixTemplate";
  description = "A template project for haskell environment in NixOS";
  license = stdenv.lib.licenses.bsd3;
}
