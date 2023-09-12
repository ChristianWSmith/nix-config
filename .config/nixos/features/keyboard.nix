{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        alt = "layer(meta)";
        meta = "layer(alt)";
      };
    };
  };
}
