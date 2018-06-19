{ mkDerivation, base, colour, diagrams-cairo, diagrams-core
, diagrams-lib, hgeometry, lens, mtl, plots, stdenv
}:
mkDerivation {
  pname = "aviation-wb";
  version = "0.0.1";
  src = ./.;
  libraryHaskellDepends = [
    base colour diagrams-cairo diagrams-core diagrams-lib hgeometry
    lens mtl plots
  ];
  homepage = "https://github.com/tonymorris/aviation-wb";
  description = "Weight/Balance";
  license = "unknown";
}
