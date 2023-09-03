{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      associations.added = {
        "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ];
      };
      defaultApplications = {
        "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ];
      };
    };
  };
}
