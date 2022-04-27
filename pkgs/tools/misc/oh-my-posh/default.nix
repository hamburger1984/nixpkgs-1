{ lib
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  version = "8.5.0";
  pname = "oh-my-posh";
  owner = "JanDeDobbeleer";

  src = fetchFromGitHub
    {
      inherit owner;
      repo = pname;
      rev = "v${version}";
      sha256 = "sha256-s00k+GvV1UNYEbXlUIPF5QcgVcyPjRlO02xiZW+r/pM=";
    };
  modRoot = "./src";
  vendorSha256 = "sha256-iBVehyfJ2WX/nSBbXeOD0ozjLSVn5LKDNgbYVopIr4w=";

  ldflags = [ "-a" "-s" "-w" "-X" "main.Version=${version}" "-extldflags" ''"-static"'' ];

  tags = [ "netgo" "osusergo" "static_build" ];

  postInstall = ''
    mkdir -p $out
    mkdir -p $out/share/oh-my-posh
    cp -r ${src}/themes $out/share/oh-my-posh
  '';

  meta = with lib; {
    description = "A prompt theme engine for any shell";
    homepage = "https://ohmyposh.dev/";
    license = licenses.mit;
    maintainers = with maintainers; [ shrykewindgrace ];
    platforms = platforms.linux;
  };
}

