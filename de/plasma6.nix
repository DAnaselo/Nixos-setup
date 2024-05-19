{pkgs, ...}:
{
 # Display Server config
 services = {
   desktopManager.plasma6.enable = true;
   displayManager.sddm = {
     enable = true;
     wayland.enable = true;
   };
   xserver = {
     enable = true;
     videoDrivers = [ "nvidia" ];
     desktopManager.xterm.enable = false;
     excludePackages = [ pkgs.xterm ];
   };
 };
}
