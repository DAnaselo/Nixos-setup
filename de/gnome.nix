{pkgs, ...}:
{
 # Display Server config
 services = {
   desktopManager.gnome.enable = true;
   displayManager.gdm = {
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
