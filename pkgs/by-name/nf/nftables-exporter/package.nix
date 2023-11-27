{ lib, stdenv, buildGoModule, fetchFromGitHub, nixosTests
}:

buildGoModule rec {
  pname = "nftables_exporter";
  version = "0.2.8";
  rev = "v${version}";

  src = fetchFromGitHub {
    inherit rev;
    owner = "metal-stack";
    repo = "nftables-exporter";
    sha256 = "sha256-zfnU+SPV9A0LlMiXofH8jA/OUeFxi5MvK6PZByxefrc=";
  };

  vendorHash = "sha256-oM68OCyMA4XB5WVgMP5/v+gwbKtGI828uzAtfGSF2ng=";

  # FIXME: tests fail due to read-only nix store
  # doCheck = false;

  excludedPackages = [ "docs/node-mixin" ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/prometheus/common/version.Version=${version}"
    "-X github.com/prometheus/common/version.Revision=${rev}"
    "-X github.com/prometheus/common/version.Branch=unknown"
    "-X github.com/prometheus/common/version.BuildUser=nix@nixpkgs"
    "-X github.com/prometheus/common/version.BuildDate=unknown"
  ];

  passthru.tests = { inherit (nixosTests.prometheus-exporters) node; };

  meta = with lib; {
    description = "Prometheus exporter for nftable metrics";
    homepage = "https://github.com/metal-stack/nftables-exporter";
    changelog = "https://github.com/metal-stack/nftables-exporter/releases";
    platforms = platforms.linux;
    license = licenses.gpl3;
    maintainers = with maintainers; [ marcusramberg ];
  };
}
