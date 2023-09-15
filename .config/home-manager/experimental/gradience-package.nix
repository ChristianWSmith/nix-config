{ stdenv
, lib
, fetchFromGitHub
, wrapGAppsHook4
, meson
, ninja
, pkg-config
, glib
, desktop-file-utils
, gettext
, librsvg
, blueprint-compiler
, python3Packages
, sassc
, appstream-glib
, libadwaita
, libportal
, libportal-gtk4
, libsoup_3
, gobject-introspection
}:

python3Packages.buildPythonApplication rec {
  pname = "gradience";
  version = "git";
  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = "GradienceTeam";
    repo = "Gradience";
    rev = "4f0a9ebc6dcd3fe6c3355f01482d450c9a0e144f";
    sha256 = "sha256-TCNTD0/EqAnLSSHFrFa/HLpl4tez3e64TjNJky0GBEU=";
  };

  format = "other";
  dontWrapGApps = true;

  nativeBuildInputs = [
    appstream-glib
    blueprint-compiler
    desktop-file-utils
    gettext
    glib
    gobject-introspection
    meson
    ninja
    pkg-config
    wrapGAppsHook4
    sassc
  ];

  buildInputs = [
    libadwaita
    libportal
    libportal-gtk4
    librsvg
    libsoup_3
  ];

  propagatedBuildInputs = with python3Packages; [
    anyascii
    jinja2
    lxml
    material-color-utilities
    pygobject3
    svglib
    yapsy
    libsass
  ];

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  meta = with lib; {
    homepage = "https://github.com/GradienceTeam/Gradience";
    description = "Customize libadwaita and GTK3 apps (with adw-gtk3)";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ foo-dogsquared ];
  };
}