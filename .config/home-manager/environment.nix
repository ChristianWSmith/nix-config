{ pkgs, ... }:
{
  home.sessionVariables = {
    SHELL = "${pkgs.fish}/bin/fish";
    TERMINAL = "footclient";
    BROWSER = "firefox";
    NIXPKGS_ALLOW_UNFREE = "1";
    NEWT_COLORS = ''
      root=blue,black
      border=blue,black
      title=blue,black
      roottext=white,black
      window=blue,black
      textbox=white,black
      button=black,blue
      compactbutton=white,black
      listbox=white,black
      actlistbox=black,white
      actsellistbox=black,blue
      checkbox=blue,black
      actcheckbox=black,blue
    '';
  };
}
