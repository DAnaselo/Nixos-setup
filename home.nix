{ config, pkgs, ... }:

{
 home.username = "anas";
 programs.zsh = {
   enable = true;
   shellAliases = {
     ll = "ls -l";
     update = "sudo nixos-rebuild switch --impure --upgrade --flake /home/anas/Nixos-setup";
     nvim = "lvim";
     neofetch = "fastfetch";
   };
   oh-my-zsh = {
     enable = true;
     #plugins = [""];
     theme = "robbyrussell";
   };
 };

 programs.kitty = {
   enable = true;
   settings = {
     font_size = "12.5";
     enable_audio_bell = "no";
     background_opacity = "0.6";
     confirm_os_window_close = "0";
     hide_window_decorations = "yes";
   };
 };

 programs.git = {
   enable = true;
   userName = "DAnaselo";
   userEmail = "abukaffanas5@gmail.com";
   extraConfig = {
     init.defaultBranch = "main";
     safe.directory = "/etc/nixos";
   };
 };

 dconf = {
   enable = true;
   settings = {
     "org/virt-manager/virt-manager/connections" = {
       autoconnect = ["qemu:///system"];
       uris = ["qemu:///system"];
     };
     "org/gnome/desktop/interface".color-scheme = "prefer-dark";
   };
 };

 # Cursors
 #home.pointerCursor = {
 #  gtk.enable = true;
   #x11.enable = true;
 #  package = pkgs.bibata-cursors;
 #  name = "Bibata-Original-Classic";
 #  size = 16;
 #};

 # Gtk Theme
 #gtk = {
 #  enable = true;
 #  theme = {
     #name = "Arc-Dark";
     #package = pkgs.arc-theme;
 #    name = "Adwaita-dark";
 #    package = pkgs.gnome.gnome-themes-extra;
 #  };
 #  iconTheme = {
 #    name = "Adwaita";
 #    package = pkgs.gnome.adwaita-icon-theme;
 #  };
 #  gtk3.extraConfig = {
 #    Settings = ''
 #      gtk-application-prefer-dark-theme=1
 #   '';
 #  };
 #  gtk4.extraConfig = {
 #    Settings = ''
 #      gtk-application-prefer-dark-theme=1
 #    '';
 #  };
 #};

 home.file.".config/hypr/hyprland.conf".source = ./dots/hypr/hyprland.conf;
 home.file.".config/hypr/hyprpaper.conf".source = ./dots/hypr/hyprpaper.conf;
 home.file.".config/waybar/config".source = ./dots/waybar/config;
 home.file.".config/waybar/style.css".source = ./dots/waybar/style.css;
 home.file.".config/rofi/config.rasi".source = ./dots/rofi/config.rasi;

  # Homemanager Version
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
