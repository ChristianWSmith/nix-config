{ pkgs, ... }:
{
  home.file = {
    ".local/share/applications/messenger-web.desktop".text = ''
      [Desktop Entry]
      Name=Messenger
      StartupWMClass=messenger
      Comment=Facebook messenger.
      Exec=chromium --new-window --enable-extensions --enable-features=WebRTCPipeWireCapturer --app="https://www.messenger.com/login/"
      GenericName=Messenger
      Icon=fbmessenger
      Type=Application
      Categories=Network;InstantMessaging;
      Path=${pkgs.chromium}/bin
    '';
    ".local/share/applications/discord-web.desktop".text = ''
      [Desktop Entry]
      Name=Discord (web)
      StartupWMClass=discord
      Comment=Discord
      Exec=chromium --new-window --enable-extensions --enable-features=WebRTCPipeWireCapturer --app="https://www.discord.com/login/"
      GenericName=Discord
      Icon=discord
      Type=Application
      Categories=Network;InstantMessaging;
      Path=${pkgs.discord}/bin 
    '';
  };
}
