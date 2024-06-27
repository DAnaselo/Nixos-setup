{config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./de/hyprland.nix
    ];
boot.supportedFilesystems = [ "ntfs" ];
  # Bootloader Configs (Using systemd-boot)
  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "nvidia-drm.fbdev=1" "NVreg_EnableGpuFirmware=0" ];
    #kernelParams = [ "quiet" "nouveau.config=NvGspRm=1" ]; #nouveauu.config=NvGspRm=1 Enables GSP Firmware On Nvidia Gpu's, Required For Mesa 24's Hardware Acc
  };

  # Systemd Boot Shutdown Timeout 
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=15s
  '';

  # Locale Settings
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
  };

  # Prop Nvidia Drivers
  hardware.nvidia = {
    modesetting.enable = true; # Makes The Nvidia Driver To Change The Mode Setting of The Gpu AKA : nvidia-drm.modeset=1
    powerManagement.enable = true; # Enable experimental Power Management Through Systemd AKA : nvidia.NVreg_PreserveVideoMemoryAllocations=1
    powerManagement.finegrained = false; # Enable Experimental Power Management of PRIME offload AKA : options nvidia "NVreg_DynamicPowerManagement=0x02
    open = false; # open source NVIDIA kernel module
    nvidiaSettings = true; # Install's The nvidia-settings Package 
    package = config.boot.kernelPackages.nvidiaPackages.beta; # Decied Of Which Version Of The Driver To Install (555.42.02)
  };

  # Hardware Acce
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau # Video Acceleration API Wrapper For VDPAU  
      libvdpau-va-gl # Wrapper For VAAPI For Library to use the Video Decode and Presentation 
      nvidia-vaapi-driver # VAAPI Wrapper For Nvidia Prop Decoders 
    ];
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
    discord
    fastfetch
    git
    gnome.zenity
    goverlay
    gparted
    htop
    lunarvim
    mangohud
    ###
    #mesa # Gpu Driver
    ###
    p7zip
    pavucontrol
    piper
    pipx
    steamtinkerlaunch
    udiskie
    unrar
    unzip
    wget
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

  # Tmux
  programs.tmux.enable = true;

  # Gamemode
  programs.gamemode.enable = true;

  # Gamescope
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # Kde Connect
  # programs.kdeconnect.enable = true;
 
  # Security Agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    protontricks.enable = true;
  };

  # rtkit is optional but recommended For Audio And Security
  security.rtkit.enable = true;

  # Various Services
  services = {
    openssh.enable = false; # Service For SSH
    flatpak.enable = true; # Service For Flatpak
    udisks2.enable = true; # Service For Mounting Drives
    ratbagd.enable = true; # Service For Configuring Logitech Devices, Needed For pkgs.piper
    pipewire = {
      enable = true;  # Enabling Pipewire Service
      alsa.enable = true; # Modern Frontend For Alsa
      alsa.support32Bit = true; # Modern Frontend For Alsa 32Bit Libs
      pulse.enable = true; # Modern Frontend For Pulseaudio
      jack.enable = true; # Modern Frontend For Jack
      wireplumber.enable = true; # Replace pipewire.media.session With Wireplumber
    };
    preload.enable = true; # Makes Frequently used apps get cached for generally snappier system
    sunshine = {
      enable = true;
      openFirewall = true;
      capSysAdmin = true; # For DRM/KMS Capture To Work on Wayland
      autoStart = false; # Stops Sunshine From Booting Up Automaticly
    };
  };

  # Firewalling
  networking.firewall = { 
    enable = true;
  };

  system = {
    stateVersion = "unstable";
  };
}
