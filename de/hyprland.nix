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
      xwayland.enable = true;
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

  # Packges For Hyprland DE
  environment.systemPackages = with pkgs; [
    cava
    copyq
    dunst
    grim
    hyprpicker
    hyprpaper
    lf
    nwg-look
    rofi-wayland
    slurp
    wlogout
    xwaylandvideobridge
  ];
}
