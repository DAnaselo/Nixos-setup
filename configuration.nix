{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./de/plasma6.nix
      ./vm/vfio.nix
    ];

  # Bootloader Configs (Using systemd-boot)
  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" ];
    #kernelParams = [ "quiet" "nouveau.config=NvGspRm=1" ];
  };

  # Systemd Boot Timeout
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=15s
  '';

  # Locale Configs
    time.timeZone = "Israel";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Noto" ]; })
  ];

  # Networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    interfaces.enp3s0.wakeOnLan = {
      enable = true;
    };
  };

  # Wake on Lan Service
  systemd.services.wakeonlan = {
    description = "WakeonLan Service";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = "true";
      ExecStart = "${pkgs.ethtool}/sbin/ethtool -s enp3s0 wol g";
    };
    wantedBy = [ "default.target" ];
  };

  # Preload Service
  systemd.services.preload = {
    description = "Preload Service";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = "true";
      ExecStart = "${pkgs.preload}/sbin/preload";
    };
    wantedBy = [ "default.target" ];
  };

  # Nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Enable Opengl
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anas = {
    isNormalUser = true;
    home = "/home/anas";
    extraGroups = [ "wheel" "input" "networkmanager" "audio" "video" ];
  };

  # Enable Zsh (Excluding home-manager config for it)
  programs.zsh.enable = true;
  users.users.anas.shell = pkgs.zsh;

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    appimage-run
    btop
    cpufetch
    discord
    fastfetch
    git
    gnome.nautilus
    gnome.zenity
    goverlay
    hardinfo
    htop
    lf
    kdePackages.kdeconnect-kde
    kdePackages.kdenlive
    lunarvim
    lutris
    mangohud
    mpv
    ###
    #mesa # Gpu Driver
    ###
    neofetch
    p7zip
    papirus-icon-theme
    pavucontrol
    protontricks
    stress
    s-tui
    tmux
    trash-cli
    unrar
    unzip
    wget
    xwaylandvideobridge
  ];

  # Various Nix Store Configs
  nixpkgs = {
    config = {
      allowUnfree = true; # Allow NonFree Packages To Be Installed
    };
  };

  # Various Nixos Configs
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ]; # Enabling The "Flake" Commmand
      auto-optimise-store = true; # Optimise (Hardlink) Nix Store On Every Rebuild
    };
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
 
  # Security Agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  # rtkit is optional but recommended For Audio
  security.rtkit.enable = true;

  # Various Services
  services = {
    openssh.enable = true; #Service For SSH
    flatpak.enable = true; #Service For Flatpak
    udisks2.enable = true; #Service For Mounting Drives
    #blueman.enable = true; #Service For Gui Bluetooth Manager
    pipewire = {
      enable = true;  # Enabling The Service
      alsa.enable = true; # Let it Replace Alsa
      alsa.support32Bit = true; # Let it Replace Alsa 32Bit Libs
      pulse.enable = true; # Let it Replace Pulseaudio
      jack.enable = true; # Let it Replace Jack Client
      wireplumber.enable = true; # Replace pipewire.media.session with better one
    };
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Enable = "Source,Sink,Media,Socket";
  };

  # Solaar
  programs.solaar = {
    enable = true;
  };

  # Firewalling
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
      { from = 47984; to = 48010; } # Sunshine
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
      { from = 47998; to = 48010; }# Sunshine
    ];  
  };

  system = {
    stateVersion = "unstable";
  };
}
