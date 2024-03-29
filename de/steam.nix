{ config, pkgs, ...}:
{
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      defaultSession = "steam";
      autoLogin = {
        enable = true;
        user = "anas";
      };
    };
  };
}
