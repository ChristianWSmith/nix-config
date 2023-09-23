{ pkgs, inputs, lib, user, ... }:
let
  createChromiumExtensionFor = browserVersion: { id, sha256, version }:
  {
    inherit id;
    crxPath = builtins.fetchurl {
      url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
      name = "${id}.crx";
      inherit sha256;
    };
    inherit version;
  };
  createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.chromium.version);
in
{
  programs.chromium = {
    enable = true;
    extensions = [
      (createChromiumExtension {
        # ublock origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
        sha256 = "sha256:15pxy8nmk3803x8wkmyqy5zgi6vf6fh4df96jzkp282fw6pw5rxr";
        version = "1.52.2";
        })
      (createChromiumExtension {
        # dark reader
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
        sha256 = "sha256:0vw7jkls9fbx9xyji0nha7r4qg1ps35xi2llaskdfd71xr8lrblj";
        version = "4.9.65";
        })
      (createChromiumExtension {
        # vimium
        id = "dbepggeogbaibhgnhhndojpepiihcmeb";
        sha256 = "sha256:0830rhd4rp1x5pn83cpnr8nmgr5za4v09676mm8gzk1a024yc661";
        version = "1.67.7";
        })
    ];
  };
}
