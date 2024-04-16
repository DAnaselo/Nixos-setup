Just Clone This Repo into Your Home Directory, Make sure to make your system "hardware-configuration.nix"
```
sudo nixos-generate-config --root /mnt
```
then go to /etc/nixos and copy "hardware-configuration.nix" then but it into the "Nixos-setup" that should be in your home dir
Finally Run this to build 
```
sudo nixos-rebuild switch --upgrade --impure --flake .
```

run this to install my flatpaks
```
flatpak install com.usebottles.bottles com.discordapp.Discord com.valvesoftware.Steam com.github.tchx84.Flatseal net.davidotek.pupgui2 com.obsproject.Studio org.kde.kdenlive org.gimp.GIMP com.github.Matoking.protontricks dev.lizardbyte.app.Sunshine org.localsend.localsend_app com.github.KRTirtho.Spotube com.atlauncher.ATLauncher io.missioncenter.MissionCenter
```
