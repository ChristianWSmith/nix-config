{ pkgs, theme, ... }:
let
  gtkCss = ''
    @define-color accent_color #${theme.colorScheme.colors.base0D};
    @define-color accent_bg_color #${theme.colorScheme.colors.base0D};
    @define-color accent_fg_color #ffffff;
    @define-color destructive_color #${theme.colorScheme.colors.base08};
    @define-color destructive_bg_color #${theme.colorScheme.colors.base08};
    @define-color destructive_fg_color #ffffff;
    @define-color success_color #${theme.colorScheme.colors.base0B};
    @define-color success_bg_color #${theme.colorScheme.colors.base0B};
    @define-color success_fg_color #ffffff;
    @define-color warning_color #${theme.colorScheme.colors.base0A};
    @define-color warning_bg_color #${theme.colorScheme.colors.base0A};
    @define-color warning_fg_color rgba(0, 0, 0, 0.8);
    @define-color error_color #${theme.colorScheme.colors.base08};
    @define-color error_bg_color #${theme.colorScheme.colors.base08};
    @define-color error_fg_color #ffffff;
    @define-color window_bg_color #${theme.colorScheme.colors.base01};
    @define-color window_fg_color #ffffff;
    @define-color view_bg_color #000000;
    @define-color view_fg_color #ffffff;
    @define-color headerbar_bg_color #${theme.colorScheme.colors.base01};
    @define-color headerbar_fg_color #ffffff;
    @define-color headerbar_border_color #ffffff;
    @define-color headerbar_backdrop_color @window_bg_color;
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
    @define-color card_bg_color rgba(255, 255, 255, 0.08);
    @define-color card_fg_color #ffffff;
    @define-color card_shade_color rgba(0, 0, 0, 0.36);
    @define-color dialog_bg_color #${theme.colorScheme.colors.base02};
    @define-color dialog_fg_color #ffffff;
    @define-color popover_bg_color #${theme.colorScheme.colors.base02};
    @define-color popover_fg_color #ffffff;
    @define-color shade_color rgba(0, 0, 0, 0.36);
    @define-color scrollbar_outline_color rgba(0, 0, 0, 0.5);
    @define-color blue_1 #${theme.colorScheme.colors.base0D};
    @define-color blue_2 #${theme.colorScheme.colors.base0D};
    @define-color blue_3 #${theme.colorScheme.colors.base0D};
    @define-color blue_4 #${theme.colorScheme.colors.base0D};
    @define-color blue_5 #${theme.colorScheme.colors.base0D};
    @define-color green_1 #${theme.colorScheme.colors.base0B};
    @define-color green_2 #${theme.colorScheme.colors.base0B};
    @define-color green_3 #${theme.colorScheme.colors.base0B};
    @define-color green_4 #${theme.colorScheme.colors.base0B};
    @define-color green_5 #${theme.colorScheme.colors.base0B};
    @define-color yellow_1 #${theme.colorScheme.colors.base0A};
    @define-color yellow_2 #${theme.colorScheme.colors.base0A};
    @define-color yellow_3 #${theme.colorScheme.colors.base0A};
    @define-color yellow_4 #${theme.colorScheme.colors.base0A};
    @define-color yellow_5 #${theme.colorScheme.colors.base0A};
    @define-color orange_1 #${theme.colorScheme.colors.base09};
    @define-color orange_2 #${theme.colorScheme.colors.base09};
    @define-color orange_3 #${theme.colorScheme.colors.base09};
    @define-color orange_4 #${theme.colorScheme.colors.base09};
    @define-color orange_5 #${theme.colorScheme.colors.base09};
    @define-color red_1 #${theme.colorScheme.colors.base08};
    @define-color red_2 #${theme.colorScheme.colors.base08};
    @define-color red_3 #${theme.colorScheme.colors.base08};
    @define-color red_4 #${theme.colorScheme.colors.base08};
    @define-color red_5 #${theme.colorScheme.colors.base08};
    @define-color purple_1 #${theme.colorScheme.colors.base0E};
    @define-color purple_2 #${theme.colorScheme.colors.base0E};
    @define-color purple_3 #${theme.colorScheme.colors.base0E};
    @define-color purple_4 #${theme.colorScheme.colors.base0E};
    @define-color purple_5 #${theme.colorScheme.colors.base0E};
    @define-color brown_1 #${theme.colorScheme.colors.base0F};
    @define-color brown_2 #${theme.colorScheme.colors.base0F};
    @define-color brown_3 #${theme.colorScheme.colors.base0F};
    @define-color brown_4 #${theme.colorScheme.colors.base0F};
    @define-color brown_5 #${theme.colorScheme.colors.base0F};
    @define-color light_1 #ffffff;
    @define-color light_2 #${theme.colorScheme.colors.base07};
    @define-color light_3 #${theme.colorScheme.colors.base06};
    @define-color light_4 #${theme.colorScheme.colors.base05};
    @define-color light_5 #${theme.colorScheme.colors.base04};
    @define-color dark_1 #${theme.colorScheme.colors.base03};
    @define-color dark_2 #${theme.colorScheme.colors.base02};
    @define-color dark_3 #${theme.colorScheme.colors.base01};
    @define-color dark_4 #${theme.colorScheme.colors.base00};
    @define-color dark_5 #000000;
  '';
in
{
  home.file = {
    # TODO: possible way to do color themeing
    # ".config/gtk-3.0/gtk.css".text = gtkCss;
    # ".config/gtk-4.0/gtk.css".text = gtkCss;
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = theme.iconThemePackage;
      name = theme.iconThemeName;
    };
    theme = {
      package = theme.themePackage;
      name = theme.themeName;
    };
    cursorTheme = {
      package = theme.cursorThemePackage;
      name = theme.cursorThemeName;
      size = theme.cursorSize;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    font = {
      package = theme.fontPackage;
      name = theme.fontName;
      size = theme.fontSize;
    };
  };

  qt = {
    enable = true;
    platformTheme = theme.qtPlatformTheme;
    style.name = theme.qtStyleName;
  };

  home.sessionVariables.GTK_THEME = theme.themeName;
}
