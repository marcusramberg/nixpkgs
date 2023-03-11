{ lib, buildNimPackage, fetchFromGitHub, unzip }:

buildNimPackage rec {
  pname = "safeset";

  version = "0.1.1";
  # nativeBuildInputs = [ unzip ];

  src = fetchFromGitHub {
    owner = "avahe-kellenberger";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-ZLdStoNVoQhRkD2iEzKxhs1UPfgnbJM9QCDHdjH7vTU=";
  };

  doCheck = true;

  meta = with lib;
    src.meta // {
      description = "safeset library for nim";
      license = [ licenses.mit ];
      maintainers = [ maintainers.marcusramberg ];
    };
}
