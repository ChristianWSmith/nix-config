{
  stdenv,
  lib,
  pkgs
}: let
  version = "git";
  hyprevents = (pkgs.callPackage ./hyprevents.nix {});
in
  stdenv.mkDerivation {
    pname = "hyprprop";
    inherit version;

    nativeBuildInputs = with pkgs; [
      jq
      socat
      slurp
    ];

    propogatedBuildInputs = [
      hyprevents
    ];

    src = pkgs.fetchFromGitHub {
      owner = "vilari-mickopf";
      repo = "hyprprop";
      rev = "77e154aaaaee911f66187689d878a41f97fabc51";
      sha256 = "sha256-5CijOK0gW8w9MY0xmLj5tZ7c/3UfrshXAABv8Ui0Hds=";
    };

    unpackPhase = ''
      mkdir -p $out
      cp -r $src/* $out
    '';

    patchPhase = ''
      sed -i "s@/usr@$out@g" $out/Makefile
      sed -i "s@/usr/share@$out/share@g" $out/hyprprop
      sed -i "s@hyprevents@${hyprevents}/bin/hyprevents@g" $out/hyprprop
      sed -i 's@\[ -n "$error" \] \&\& prop@\[ -n "$error" \] \&\& cleanup \&\& exit@g' $out/hyprprop
    '';

    installPhase = ''
      cd $out
      make
      chmod +x $out/bin/*
      chmod +x $out/share/hyprprop/*
      rm $out/hyprprop
      rm $out/README.md
      rm $out/event_handler
      rm $out/Makefile
    '';

    meta = with lib; {
      description = "xprop for Hyprland";
      platforms = platforms.linux;
    };
  }
