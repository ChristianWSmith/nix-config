{ inputs, user, ... }:
{
  programs.firefox = {
    enable = true;
    profiles."${user}" = {
      extensions = [
        inputs.firefox-addons.packages."x86_64-linux".ublock-origin
        inputs.firefox-addons.packages."x86_64-linux".darkreader
        inputs.firefox-addons.packages."x86_64-linux".vimium
      ];
      settings = {
        "browser.tabs.inTitlebar" = 0;
  "browser.toolbars.bookmarks.visibility" = "always";
  "browser.bookmarks.addedImportButton" = false;
  "browser.startup.firstrunSkipsHomepage" = false;
  "browser.startup.homepage" = "www.google.com";
      };
      bookmarks = [
        {
          name = "Nix Sites";
          toolbar = true;
          bookmarks = [
            {
              name = "NixOS Wiki";
              url = "https://nixos.wiki/wiki/Main_Page";
            }
            {
              name = "NixOS Packages";
              url = "https://search.nixos.org/packages";
            }
            {
              name = "NixOS Options";
              url = "https://search.nixos.org/options";
            }
            {
              name = "Home Manager Options";
              url = "https://mipmip.github.io/home-manager-option-search/";
            }
            {
              name = "NUR";
              url = "https://nur.nix-community.org/";
            }
          ];
        }
      ];
    };
  };
}
