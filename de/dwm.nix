{ config, pkgs, ... }:

{
  # Xserver Configuraion For DWM
  services = {
    # Setting up Xresources
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    # Enabling Dwm
      windowManager.dwm.enable = true;
      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+dwm";
        autoLogin = {
          enable = true;
          user = "anas";
        };
        sessionCommands = ''
          ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
            Xft.dpi:	128
            Xft.autohint:	0
            Xft.lcdfilter:	lcddefault
            Xft.hintstyle:	hintfull
            Xft.hinting:	1
            Xft.antialias:	1
            Xft.rgba:	rbg
          ''}
        '';
      };
    };
  };

  # Define The Custom Configs For Every Suckless Package
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {src = /home/anas/git/dwm-setup/dwm-6.4;});
      st = prev.st.overrideAttrs (old: {src = /home/anas/git/dwm-setup/st-0.9;});
      dmenu = prev.dmenu.overrideAttrs (old: {src = /home/anas/git/dwm-setup/dmenu-5.2;});
      slock = prev.slock.overrideAttrs (old: {src = /home/anas/git/dwm-setup/slock-1.5;});
      slstatus = prev.slstatus.overrideAttrs (old: {src = /home/anas/git/dwm-setup/slstatus-1.0;});
    })
  ];

  # Packages For DWM DE
  environment.systemPackages = with pkgs; [
    st
    dmenu
    slock
    slstatus
    xclip
    nitrogen
    pulseaudio
    rofi
    flameshot
  ];


  # File Picker And Better Flatpak Integration
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  
  # Its a polkit
  security.polkit.enable = true;

  # Running The Polkit as a service
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
} 
