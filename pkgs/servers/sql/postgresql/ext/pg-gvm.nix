{
  buildPostgresqlExtension,
  cmake,
  fetchFromGitHub,
  glib,
  gvm-libs,
  icu,
  lib,
  libical,
  pcre2,
  pkg-config,
  postgresql,
}:

buildPostgresqlExtension (finalAttrs: {
  pname = "pg-gvm";
  version = "22.6.7";

  src = fetchFromGitHub {
    owner = "greenbone";
    repo = "pg-gvm";
    rev = "refs/tags/v${finalAttrs.version}";
    hash = "sha256-Sa9ltW3KV/69OCxD3gRcp5owL0oW+z3fs4fRBHbSh30=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    glib
    gvm-libs
    icu
    libical
    pcre2
  ];

  meta = {
    description = "Greenbone Library for helper functions in PostgreSQL";
    homepage = "https://github.com/greenbone/pg-gvm";
    changelog = "https://github.com/greenbone/pg-gvm/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ tochiaha ];
    mainProgram = "pg-gvm";
    platforms = postgresql.meta.platforms;
  };
})
