{pkgs, ...}:
{
 # Display Server config
 services = {
   xserver = {
     enable = true;
     videoDrivers = [ "nvidia" ];
     desktopManager.gnome.enable = true;
     displayManager.gdm.enable  = true;
     desktopManager.xterm.enable = false;
     excludePackages = [ pkgs.xterm ];
   };
 };

 # Gnome Doesn't Like PulseAudio
 hardware.pulseaudio.enable = false;

}
