{
  stdenv,
  lib,
  zip
}: let
  version = "2023-09-07";
in
  stdenv.mkDerivation {
    pname = "nixsur-plymouth-theme";
    inherit version;

    nativeBuildInputs = [
      zip
    ];

    sourceRoot = ".";

    src = [
      ./nixsur.tar.gz
    ];

    unpackPhase = ''
      for srcFile in $src; do
        local tgt=$(echo $srcFile | cut --delimiter=- --fields=2-)
        cp -r $srcFile $tgt
      done
    '';

    installPhase = ''
      mkdir -p $out/share/plymouth/themes
      tar xzf ./nixsur.tar.gz
      cp -r ./nixsur $out/share/plymouth/themes/
      chmod +w $out/share/plymouth/themes/nixsur/nixsur.plymouth
      echo "ImageDir=$out/share/plymouth/themes/nixsur" >> $out/share/plymouth/themes/nixsur/nixsur.plymouth
      echo "ScriptFile=$out/share/plymouth/themes/nixsur/nixsur.script" >> $out/share/plymouth/themes/nixsur/nixsur.plymouth
      chmod -w $out/share/plymouth/themes/nixsur/nixsur.plymouth
    '';

    meta = with lib; {
      description = "NixSur plymouth theme";
      platforms = platforms.linux;
    };
  }
