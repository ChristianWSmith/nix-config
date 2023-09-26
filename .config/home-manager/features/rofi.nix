{ pkgs, config, theme, ... }:
let
  guiAppLauncher = pkgs.writeShellScriptBin "gui-app-launcher" ''
    rofi -show drun
  '';
in
{
  home.packages = [guiAppLauncher];

  programs.rofi.enable = true;
  programs.rofi.theme = 
    let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "configuration" = {
        modi = "drun";
        show-icons = true;
        display-drun = ">";
        drun-display-format = "{name}";
        hover-select = true;
        me-select-entry = "";
        me-accept-entry = map mkLiteral [ "MousePrimary" "MouseSecondary" "MouseDPrimary" ];
      };

      "*" = {
          background = mkLiteral "#${theme.colorScheme.background1Hex}FF";
          background-alt = mkLiteral "#${theme.colorScheme.background2Hex}FF";
          foreground = mkLiteral "#${theme.colorScheme.foreground1Hex}FF";
          selected = mkLiteral "#${theme.colorScheme.accentHex}FF";
          active = mkLiteral "#${theme.colorScheme.successHex}FF";
          urgent = mkLiteral "#${theme.colorScheme.dangerHex}FF";
          font = "${theme.fontName} ${builtins.toString theme.fontSize}";
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
          border = mkLiteral "${builtins.toString theme.borderWidth}px solid";
          border-radius = mkLiteral "${builtins.toString theme.borderRadius}px";
          border-color = mkLiteral "#${theme.colorScheme.foreground1Hex}${theme.colorScheme.transparencyHeavyShadeHex}";
          background-color = mkLiteral "#${theme.colorScheme.foreground1Hex}${theme.colorScheme.transparencyLightShadeHex}";
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
          border-radius = mkLiteral "0px";
          border-color = mkLiteral "@selected";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground";
          cursor = "default";
      };
      "scrollbar" = {
          handle-width = mkLiteral "5px";
          handle-color = mkLiteral "@selected";
          border-radius = mkLiteral "0px";
          background-color = mkLiteral "@background-alt";
      };

      "element" = {
          enabled = mkLiteral "true";
          spacing = mkLiteral "15px";
          margin = mkLiteral "0px";
          padding = mkLiteral "35px 10px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "15px";
          border-color = mkLiteral "@selected";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground";
          orientation = mkLiteral "vertical";
          cursor = mkLiteral "pointer";
      };
      "element normal.normal" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground";
      };
      "element selected.normal" = {
          background-color = mkLiteral "#${theme.colorScheme.foreground1Hex}${theme.colorScheme.transparencyLightShadeHex}";
          text-color = mkLiteral "@foreground";
      };
      "element-icon" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          size = mkLiteral "72px";
          cursor = mkLiteral "inherit";
      };
      "element-text" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          highlight = mkLiteral "inherit";
          cursor = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
      };

      "error-message" = {
          padding = mkLiteral "100px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px";
          border-color = mkLiteral "@selected";
          background-color = mkLiteral "#${theme.colorScheme.background1Hex}${theme.colorScheme.transparencyLightShadeHex}";
          text-color = mkLiteral "@foreground";
      };
      "textbox" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
          highlight = mkLiteral "none";
      };
    };
}