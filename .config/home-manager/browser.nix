{ inputs, user, ... }:
{
  programs.firefox = {
    enable = true;
    profiles."${user}" = {
      extensions = [
        inputs.firefox-addons.packages."x86_64-linux".ublock-origin
        inputs.firefox-addons.packages."x86_64-linux".darkreader
        inputs.firefox-addons.packages."x86_64-linux".vimium
        inputs.firefox-addons.packages."x86_64-linux".new-tab-override
      ];
      settings = {
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.bookmarks.addedImportButton" = false;
        "browser.startup.firstrunSkipsHomepage" = false;
        "browser.startup.homepage" = "www.google.com";
      };
    };
  };
}
