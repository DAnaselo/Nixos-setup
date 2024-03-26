{ config, pkgs, ...}:
{

 # Display Server config
 services = {
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
