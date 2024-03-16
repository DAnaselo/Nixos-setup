{ config, pkgs, ... }:

{

  home.username = "anas";

  programs.zsh = {
   enable = true;
   shellAliases = {
     ll = "ls -l";
     update = "sudo nixos-rebuild switch --impure --upgrade --flake /etc/nixos";
     nvim = "lvim";
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
 home.pointerCursor = {
   gtk.enable = true;
   # x11.enable = true;
   package = pkgs.bibata-cursors;
   name = "Bibata-Modern-Classic";
   size = 16;
 };

 # Gtk Theme
  gtk = {
    enable = true;
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Papirus-Icons";
      package = pkgs.papirus-icon-theme;
    };
  };

 home.file.".config/hypr/hyprland.conf".source = /etc/nixos/dots/hypr/hyprland.conf;
 home.file.".config/hypr/hyprpaper.conf".source = /etc/nixos/dots/hypr/hyprpaper.conf;
 home.file.".config/waybar/config".source = /etc/nixos/dots/waybar/config;
 home.file.".config/waybar/style.css".source = /etc/nixos/dots/waybar/style.css;
 home.file.".config/rofi/config.rasi".source = /etc/nixos/dots/rofi/config.rasi;

  # Homemanager Version
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
