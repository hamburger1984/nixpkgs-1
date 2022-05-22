{ stdenv
, lib
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "graphite-kde-theme";
  version = "2022-05-20";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = pname;
    rev = "b971f7b6ffe47c31562ba594b1afcaa78ab41abd";
    sha256 = "sha256-bro/Vyny/7oPiR57QJVBnWTxTpwmsi5mCA8i9eReBvg=";
  };

  installPhase = ''
    runHook preInstall

    patchShebangs install.sh

    substituteInPlace install.sh \
      --replace '$HOME/.local' $out \
      --replace '$HOME/.config' $out/share

    name= ./install.sh --dest $out/share/themes

    mkdir -p $out/share/sddm/themes
    cp -a sddm/Graphite $out/share/sddm/themes/

    runHook postInstall
  '';

  meta = with lib; {
    description = "A flat Design theme for KDE Plasma desktop";
    homepage = "https://github.com/vinceliuice/Graphite-kde-theme";
    license = licenses.gpl3Only;
    platforms = platforms.all;
    maintainers = [ maintainers.romildo ];
  };
}
