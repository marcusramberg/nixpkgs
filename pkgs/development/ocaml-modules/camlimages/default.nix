{
  lib,
  fetchFromGitLab,
  buildDunePackage,
  findlib,
  dune-configurator,
  cppo,
  graphics,
  lablgtk,
  stdio,
}:

buildDunePackage rec {
  pname = "camlimages";
  version = "5.0.4";

  minimalOCamlVersion = "4.07";

  src = fetchFromGitLab {
    owner = "camlspotter";
    repo = pname;
    rev = version;
    sha256 = "1m2c76ghisg73dikz2ifdkrbkgiwa0hcmp21f2fm2rkbf02rq3f4";
  };

  # stdio v0.17 compatibility; also replaces `String.lowercase` with `String.lowercase_ascii`
  patches = [ ./camlimages.patch ];

  nativeBuildInputs = [ cppo ];
  buildInputs = [
    dune-configurator
    findlib
    graphics
    lablgtk
    stdio
  ];

  meta = with lib; {
    branch = "5.0";
    inherit (src.meta) homepage;
    description = "OCaml image processing library";
    license = licenses.lgpl2;
    maintainers = [
      maintainers.vbgl
      maintainers.mt-caret
    ];
  };
}
