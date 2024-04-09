{ config, pkgs, ...}:

{
  #Xserver Configs
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      displayManager = {
        autoLogin.enable = true;
        autoLogin.user = "anas";
        defaultSession = "steam";
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
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
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
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
    rofi-wayland
    slurp
    wlogout
  ];
}
