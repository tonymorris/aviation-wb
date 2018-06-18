{ mkDerivation, base, colour, diagrams-cairo, diagrams-core
, diagrams-lib, lens, plots, stdenv
}:
mkDerivation {
  pname = "aviation-wb";
  version = "0.0.1";
  src = ./.;
  libraryHaskellDepends = [
    base colour diagrams-cairo diagrams-core diagrams-lib lens plots
  ];
  homepage = "https://github.com/tonymorris/aviation-wb";
  description = "Weight/Balance";
  license = "unknown";
}
