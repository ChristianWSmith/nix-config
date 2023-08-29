{ pkgs, config, ... }:
let
  launcher = pkgs.writeShellScriptBin "app-launcher" ''
    PIDFILE="/tmp/app-launcher.pid"
    COMMAND="rofi -show drun -drun-use-desktop-cache -cache-dir ~/.cache"
    if ps -p $(cat $PIDFILE);
    then
      pkill -f "$COMMAND"
    else
      echo "$$" > $PIDFILE
      $COMMAND
    fi
  '';

  dmenu = pkgs.writeShellScriptBin "dmenu" ''
    rofi -dmenu $@
  '';
in
{
  home.packages = [ launcher dmenu ];
  programs.rofi.enable = true;


  programs.rofi.theme = 
    let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
# TODO: -FORMAT THIS
"configuration" = {
    modi = "drun";
    show-icons = true;
    display-drun = ">";
    drun-display-format = "{name}";
};

"*" = {
    background = mkLiteral "#1E2127FF";
    background-alt = mkLiteral "#282B31FF";
    foreground = mkLiteral "#FFFFFFFF";
    selected = mkLiteral "#61AFEFFF";
    active = mkLiteral "#98C379FF";
    urgent = mkLiteral "#E06C75FF";
    font = "Noto Sans 11";
};

"window" = {
    transparency = "real";
    location = mkLiteral "center";
    anchor = mkLiteral "center";
    fullscreen = mkLiteral "true";
    width = mkLiteral "100%";
    height = mkLiteral "100%";
    x-offset = mkLiteral "0px";
    y-offset = mkLiteral "0px";

    enabled = mkLiteral "true";
    margin = mkLiteral "0px";
    padding = mkLiteral "0px";
    border = mkLiteral "0px solid";
    border-radius = mkLiteral "0px";
    border-color = mkLiteral "@selected";
    background-color = mkLiteral "black / 10%";
    cursor = "default";
};

"mainbox" = {
    enabled = mkLiteral "true";
    spacing = mkLiteral "100px";
    margin = mkLiteral "0px";
    padding = mkLiteral "100px 225px";
    border = mkLiteral "0px solid";
    border-radius = mkLiteral "0px 0px 0px 0px";
    border-color = mkLiteral "@selected";
    background-color = mkLiteral "transparent";
    children = map mkLiteral [ "inputbar" "listview" ];
};

"inputbar" = {
    enabled = mkLiteral "true";
    spacing = mkLiteral "10px";
    margin = mkLiteral "0% 28%";
    padding = mkLiteral "10px";
    border = mkLiteral "1px solid";
    border-radius = mkLiteral "6px";
    border-color = mkLiteral "white / 25%";
    background-color = mkLiteral "white / 5%";
    text-color = mkLiteral "@foreground";
    children = map mkLiteral [ "prompt" "entry" ];
};

"prompt" = {
    enabled = mkLiteral "true";
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "inherit";
};
"textbox-prompt-colon" = {
    enabled = mkLiteral "true";
    expand = mkLiteral "false";
    str = "::";
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "inherit";
};
"entry" = {
    enabled = mkLiteral "true";
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "inherit";
    cursor = mkLiteral "text";
    placeholder = "Search";
    placeholder-color = mkLiteral "inherit";
};

"listview" = {
    enabled = mkLiteral "true";
    columns = mkLiteral "7";
    lines = mkLiteral "4";
    cycle = mkLiteral "true";
    dynamic = mkLiteral "true";
    scrollbar = mkLiteral "false";
    layout = mkLiteral "vertical";
    reverse = mkLiteral "false";
    fixed-height = mkLiteral "true";
    fixed-columns = mkLiteral "true";
    
    spacing = mkLiteral "0px";
    margin = mkLiteral "0px";
    padding = mkLiteral "0px";
    border = mkLiteral "0px solid";
    border-radius=               mkLiteral "0px";
    border-color=                mkLiteral "@selected";
    background-color=            mkLiteral "transparent";
    text-color=                  mkLiteral "@foreground";
    cursor=                      "default";
};
"scrollbar" = {
    handle-width=                mkLiteral "5px";
    handle-color=                mkLiteral "@selected";
    border-radius=               mkLiteral "0px";
    background-color=            mkLiteral "@background-alt";
};

"element" = {
    enabled=                     mkLiteral "true";
    spacing=                     mkLiteral "15px";
    margin=                      mkLiteral "0px";
    padding=                     mkLiteral "35px 10px";
    border=                      mkLiteral "0px solid";
    border-radius=               mkLiteral "15px";
    border-color=                mkLiteral "@selected";
    background-color=            mkLiteral "transparent";
    text-color=                  mkLiteral "@foreground";
    orientation=                 mkLiteral "vertical";
    cursor=                      mkLiteral "pointer";
};
"element normal.normal" = {
    background-color=            mkLiteral "transparent";
    text-color=                  mkLiteral "@foreground";
};
"element selected.normal" = {
    background-color=            mkLiteral "white / 5%";
    text-color=                  mkLiteral "@foreground";
};
"element-icon" = {
    background-color=            mkLiteral "transparent";
    text-color=                  mkLiteral "inherit";
    size=                        mkLiteral "72px";
    cursor=                      mkLiteral "inherit";
};
"element-text" = {
    background-color=            mkLiteral "transparent";
    text-color=                  mkLiteral "inherit";
    highlight=                   mkLiteral "inherit";
    cursor=                      mkLiteral "inherit";
    vertical-align=              mkLiteral "0.5";
    horizontal-align=            mkLiteral "0.5";
};

"error-message" = {
    padding=                     mkLiteral "100px";
    border=                      mkLiteral "0px solid";
    border-radius=               mkLiteral "0px";
    border-color=                mkLiteral "@selected";
    background-color=            mkLiteral "black / 10%";
    text-color=                  mkLiteral "@foreground";
};
"textbox" = {
    background-color=            mkLiteral "transparent";
    text-color=                  mkLiteral "@foreground";
    vertical-align=              mkLiteral "0.5";
    horizontal-align=            mkLiteral "0.0";
    highlight=                   mkLiteral "none";
};
# TODO: -FORMAT THIS

    };
}
