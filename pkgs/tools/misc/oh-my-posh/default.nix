{ lib
, fetchFromGitHub
, buildGoModule
, getThemes ? false
}:

buildGoModule rec {
  version = "7.85.2";
  pname = "oh-my-posh";
  owner = "JanDeDobbeleer";

  src = fetchFromGitHub
    {
      inherit owner;
      repo = pname;
      rev = "v${version}";
      sha256 = "OAS0Uehgy4UFkhe+C7TbFTTBJkAS3G4g8ruyS90DqOQ=";
    };
  modRoot = "./src";
  vendorSha256 = "trG+w+xUlfsBkMfkM7vRxO41vXdymPFp5IYILR7hlQc=";

  ldflags = [ "-a" "-s" "-w" "-X" "main.Version=${version}" "-extldflags" ''"-static"'' ];

  tags = [ "netgo" "osusergo" "static_build" ];

  dontFixup = true;

  meta = with lib; {
    license = licenses.mit;
    homepage = "https://ohmyposh.dev/";
    description = "A prompt theme engine for any shell";
    maintainers = with maintainers; [ shrykewindgrace ];
  };

  postInstall = lib.optionalString getThemes ''
    mkdir -p $out
    cp -r ${src}/themes $out
  '';
}

