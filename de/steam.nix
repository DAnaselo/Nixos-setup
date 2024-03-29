{ config, pkgs, ...}:
{
  services.xserver = {
    enable = true
    display.Manager = {
      lightdm.enable = true;
      defaultSession = "steam"
      autoLogin = {
        enable = true;
        user = "anas"
      };
    };
  };
}
