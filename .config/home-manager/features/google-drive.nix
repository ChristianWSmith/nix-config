{ pkgs, user, ... }:
let
  mountGoogleDrive = pkgs.writeShellScriptBin "mount-google-drive" ''
    mkdir -p ${user.home}/GoogleDrive
    if ! rclone listremotes | grep GoogleDrive &> /dev/null; then
      echo "Attempting to create GoogleDrive rclone config..."
      rclone config create GoogleDrive drive
    else
      echo "GoogleDrive rclone config already exists."
    fi
    if rclone listremotes | grep GoogleDrive &> /dev/null; then
      if ! mount | grep GoogleDrive &> /dev/null; then
        echo "Mounting GoogleDrive with rclone..."
        rclone mount --vfs-cache-mode minimal GoogleDrive: ${user.home}/GoogleDrive & disown
      else
        echo "GoogleDrive already mounted."
      fi
    else
      echo "GoogleDrive rclone config does not exist even after attempting to create it."
    fi
  '';
  unmountGoogleDrive = pkgs.writeShellScriptBin "unmount-google-drive" ''
    if rclone listremotes | grep GoogleDrive &> /dev/null; then
      if mount | grep GoogleDrive &> /dev/null; then
        echo "Unmounting GoogleDrive..."
        fusermount -u ${user.home}/GoogleDrive
      else
        echo "GoogleDrive already not mounted."
      fi
    else
      echo "GoogleDrive rclone config does not exist."
    fi 
  '';
  backupSteamShaderCache = pkgs.writeShellScriptBin "backup-steam-shader-cache" ''
    mkdir -p ${user.home}/GoogleDrive/shadercache
    rsync --info=progress2 --info=name0 -a ${user.home}/.steam/steam/steamapps/shadercache/ ${user.home}/GoogleDrive/shadercache
  '';
  restoreSteamShaderCache = pkgs.writeShellScriptBin "restore-steam-shader-cache" ''
    mkdir -p ${user.home}/GoogleDrive/shadercache
    rsync --info=progress2 --info=name0 -a ${user.home}/GoogleDrive/shadercache/ ${user.home}/.steam/steam/steamapps/shadercache
  '';
in
{
  home.packages = [ 
    pkgs.rclone 
    mountGoogleDrive 
    unmountGoogleDrive 
    backupSteamShaderCache 
    restoreSteamShaderCache 
  ];
}
