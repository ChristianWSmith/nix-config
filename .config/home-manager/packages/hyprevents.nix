{
  stdenv,
  lib,
  pkgs
}: let
  version = "git";
in
  stdenv.mkDerivation {
    pname = "hyprevents";
    inherit version;

    nativeBuildInputs = with pkgs; [
      socat
    ];

    src = pkgs.fetchFromGitHub {
      owner = "vilari-mickopf";
      repo = "hyprevents";
      rev = "95426ae4dac70c6e6ed67918dbf3bdedfdf28f37";
      sha256 = "sha256-SLt2ukCJbfkvnGLgy9x7/3BoI2OqC4VIdgM5z768EXc=";
    };

    unpackPhase = ''
      mkdir -p $out
      cp -r $src/* $out
    '';

    patchPhase = ''
      sed -i "s@/usr@$out@g" $out/Makefile
      sed -i "s@/usr/share@$out/share@g" $out/hyprevents
      sed -i "s@/usr/share@$out/share@g" $out/event_loader
    '';

    installPhase = ''
      cd $out
      make
      chmod +x $out/bin/*
      chmod +x $out/share/hyprevents/*
      rm $out/event_loader
      rm $out/Makefile
      rm $out/event_handler
      rm $out/hyprevents
      rm $out/README.md
    '';

    meta = with lib; {
      description = "Invoke shell functions in response to Hyprland socket2 events";
      platforms = platforms.linux;
    };
  }
