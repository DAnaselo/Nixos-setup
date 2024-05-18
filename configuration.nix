{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./de/hyprland.nix
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
    kernelParams = [ "quiet" "nvidia_drm.fbdev=1" ]; # nvidia_drm.fbdev=1 Is For A Bug In Kernel 6.9 That Doesn't Wayland Server's Run Without this param on
    #kernelParams = [ "quiet" "nouveau.config=NvGspRm=1" ]; nouveauu.config=NvGspRm=1 Enables GSP Firmware On Nvidia Gpu's, Required For Mesa 24's Hardware Acc
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

  # Prop Nvidia Drivers
  hardware.nvidia = {
    modesetting.enable = true; # nvidia-drm.modeset=1
    powerManagement.enable = true; # NVreg_PreserveVideoMemoryAllocations=1
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Hardware Acceleration
  hardware.opengl = {
    enable = true;
    driSupport = true; # Vulkan 
    driSupport32Bit = true; # 32Bit Vulkan
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      nvidia-vaapi-driver
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
    brave
    btop
    egl-wayland
    fastfetch
    gamescope
    git
    gnome.nautilus
    gnome.zenity
    goverlay
    gparted
    htop
    kdePackages.kdeconnect-kde
    lunarvim
    mangohud
    mpv
    ###
    #mesa # Gpu Driver
    ###
    nvidia-vaapi-driver
    p7zip
    pavucontrol
    piper
    protontricks
    protonup-qt
    sunshine
    tmux
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

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  # Gamemode
  programs.gamemode.enable = true;
 
  # Security Agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # rtkit is optional but recommended For Audio And Security
  security.rtkit.enable = true;

  # Various Services
  services = {
    openssh.enable = true; # Service For SSH
    flatpak.enable = true; # Service For Flatpak
    udisks2.enable = true; # Service For Mounting Drives
    ratbagd.enable = true; # Service For Configuring Logitech Devices
    blueman.enable = true; # Gui Bluetooth Manager
    pipewire = {
      enable = true;  # Enabling Pipewire Service
      alsa.enable = true; # Modern Frontend For Alsa
      alsa.support32Bit = true; # Modern Frontend For Alsa 32Bit Libs
      pulse.enable = true; # Modern Frontend For Pulseaudio
      jack.enable = true; # Modern Frontend For Jack
      wireplumber.enable = true; # Replace pipewire.media.session With Wireplumber
    };
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Enable = "Source,Sink,Media,Socket";
  };

  # Firewalling
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
      { from = 47984; to = 48010; } # Sunshine
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; }  # KDE Connect
      { from = 47998; to = 48010; } # Sunshine
    ];  
  };

  system = {
    stateVersion = "unstable";
  };
}
