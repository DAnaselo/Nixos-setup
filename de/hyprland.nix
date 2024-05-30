{pkgs, ...}:
{
  # Display Server Configuration
  services = {
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "anas";
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      desktopManager.xterm.enable = false;
      excludePackages = [ pkgs.xterm ];
    };
  };

  # Hyprland It Self
  programs = {
    hyprland = {
      enable = true;
    };
    waybar = {
      enable = true;
    };
  };

  xdg.portal = { 
    enable = true; 
    extraPortals = [ 
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Various Services
  services = {
    blueman.enable = true;
  };

  # Packges For Hyprland DE
  environment.systemPackages = with pkgs; [
    cava
    copyq
    dunst
    grim
    hyprpicker
    hyprpaper
    gnome.nautilus
    rofi-wayland
    slurp
    wlogout
  ];
}
