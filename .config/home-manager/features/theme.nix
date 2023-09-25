{ pkgs, user, theme, ... }:
let
  gtkCss = ''
    @define-color accent_color #${theme.colorScheme.blueHex};
    @define-color accent_bg_color #${theme.colorScheme.blueHex};
    @define-color accent_fg_color #${theme.colorScheme.foreground1Hex};
    @define-color destructive_color #${theme.colorScheme.redHex};
    @define-color destructive_bg_color #${theme.colorScheme.redHex};
    @define-color destructive_fg_color #${theme.colorScheme.foreground1Hex};
    @define-color success_color #${theme.colorScheme.greenHex};
    @define-color success_bg_color #${theme.colorScheme.greenHex};
    @define-color success_fg_color #${theme.colorScheme.foreground1Hex};
    @define-color warning_color #${theme.colorScheme.yellowHex};
    @define-color warning_bg_color #${theme.colorScheme.yellowHex};
    @define-color warning_fg_color rgba(${theme.colorScheme.background1RGB},${theme.colorScheme.transparencyBackgroundRGB});
    @define-color error_color #${theme.colorScheme.redHex};
    @define-color error_bg_color #${theme.colorScheme.redHex};
    @define-color error_fg_color #${theme.colorScheme.foreground1Hex};
    @define-color window_bg_color #${theme.colorScheme.background2Hex};
    @define-color window_fg_color #${theme.colorScheme.foreground1Hex};
    @define-color view_bg_color #${theme.colorScheme.background1Hex};
    @define-color view_fg_color #${theme.colorScheme.foreground1Hex};
    @define-color headerbar_bg_color #${theme.colorScheme.background2Hex};
    @define-color headerbar_fg_color #${theme.colorScheme.foreground1Hex};
    @define-color headerbar_border_color #${theme.colorScheme.foreground1Hex};
    @define-color headerbar_backdrop_color #${theme.colorScheme.background2Hex};
    @define-color headerbar_shade_color rgba(${theme.colorScheme.background1RGB},${theme.colorScheme.transparencyHeavyShadeRGB});
    @define-color card_bg_color rgba(${theme.colorScheme.foreground1RGB},${theme.colorScheme.transparencyLightShadeRGB});
    @define-color card_fg_color #${theme.colorScheme.foreground1Hex};
    @define-color card_shade_color rgba(${theme.colorScheme.background1RGB},${theme.colorScheme.transparencyHeavyShadeRGB});
    @define-color dialog_bg_color #${theme.colorScheme.background3Hex};
    @define-color dialog_fg_color #${theme.colorScheme.foreground1Hex};
    @define-color popover_bg_color #${theme.colorScheme.background3Hex};
    @define-color popover_fg_color #${theme.colorScheme.foreground1Hex};
    @define-color shade_color rgba(${theme.colorScheme.background1RGB},${theme.colorScheme.transparencyHeavyShadeRGB});
    @define-color scrollbar_outline_color rgba(${theme.colorScheme.background1RGB},${theme.colorScheme.transparencyHeavyShadeRGB});
    @define-color blue_1 #${theme.colorScheme.blueHex};
    @define-color blue_2 #${theme.colorScheme.blueHex};
    @define-color blue_3 #${theme.colorScheme.blueHex};
    @define-color blue_4 #${theme.colorScheme.blueHex};
    @define-color blue_5 #${theme.colorScheme.blueHex};
    @define-color green_1 #${theme.colorScheme.greenHex};
    @define-color green_2 #${theme.colorScheme.greenHex};
    @define-color green_3 #${theme.colorScheme.greenHex};
    @define-color green_4 #${theme.colorScheme.greenHex};
    @define-color green_5 #${theme.colorScheme.greenHex};
    @define-color yellow_1 #${theme.colorScheme.yellowHex};
    @define-color yellow_2 #${theme.colorScheme.yellowHex};
    @define-color yellow_3 #${theme.colorScheme.yellowHex};
    @define-color yellow_4 #${theme.colorScheme.yellowHex};
    @define-color yellow_5 #${theme.colorScheme.yellowHex};
    @define-color orange_1 #${theme.colorScheme.orangeHex};
    @define-color orange_2 #${theme.colorScheme.orangeHex};
    @define-color orange_3 #${theme.colorScheme.orangeHex};
    @define-color orange_4 #${theme.colorScheme.orangeHex};
    @define-color orange_5 #${theme.colorScheme.orangeHex};
    @define-color red_1 #${theme.colorScheme.redHex};
    @define-color red_2 #${theme.colorScheme.redHex};
    @define-color red_3 #${theme.colorScheme.redHex};
    @define-color red_4 #${theme.colorScheme.redHex};
    @define-color red_5 #${theme.colorScheme.redHex};
    @define-color purple_1 #${theme.colorScheme.magentaHex};
    @define-color purple_2 #${theme.colorScheme.magentaHex};
    @define-color purple_3 #${theme.colorScheme.magentaHex};
    @define-color purple_4 #${theme.colorScheme.magentaHex};
    @define-color purple_5 #${theme.colorScheme.magentaHex};
    @define-color brown_1 #${theme.colorScheme.brownHex};
    @define-color brown_2 #${theme.colorScheme.brownHex};
    @define-color brown_3 #${theme.colorScheme.brownHex};
    @define-color brown_4 #${theme.colorScheme.brownHex};
    @define-color brown_5 #${theme.colorScheme.brownHex};
    @define-color light_1 #${theme.colorScheme.foreground1Hex};
    @define-color light_2 #${theme.colorScheme.foreground1Hex};
    @define-color light_3 #${theme.colorScheme.foreground2Hex};
    @define-color light_4 #${theme.colorScheme.foreground3Hex};
    @define-color light_5 #${theme.colorScheme.foreground4Hex};
    @define-color dark_1 #${theme.colorScheme.background4Hex};
    @define-color dark_2 #${theme.colorScheme.background3Hex};
    @define-color dark_3 #${theme.colorScheme.background2Hex};
    @define-color dark_4 #${theme.colorScheme.background1Hex};
    @define-color dark_5 #${theme.colorScheme.background1Hex};
  '';
in
{
  home.file = {
    ".config/gtk-3.0/gtk.css".text = gtkCss;
    ".config/gtk-4.0/gtk.css".text = gtkCss;
  };
  home.pointerCursor = {
    package = theme.cursorThemePackage;
    name = theme.cursorThemeName;
    size = theme.cursorSize;
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };

  fonts.fontconfig.enable = true;
  
  gtk = {
    enable = true;
    font = {
      package = theme.fontPackage;
      name = theme.fontName;
      size = theme.fontSize;
    };
    theme.package = theme.themePackage;
    theme.name = theme.themeName;
    iconTheme.package = theme.iconThemePackage;
    iconTheme.name = theme.iconThemeName;
    gtk3.bookmarks = [
      "file://${user.home}/Documents Documents"
      "file://${user.home}/Downloads Downloads"
      "file://${user.home}/Music Music"
      "file://${user.home}/Pictures Pictures"
      "file://${user.home}/Templates Templates"
      "file://${user.home}/Videos Videos"
    ];
  };

  qt = {
    enable = true;
    platformTheme = theme.qtPlatformTheme;
    style.name = theme.qtStyleName;
  };
}
