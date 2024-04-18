Make sure to make your system "hardware-configuration.nix"
```
sudo nixos-generate-config --root /mnt
```
Just Clone This Repo into Your Home Directory.
Then go to /etc/nixos and copy "hardware-configuration.nix" then but it into the "Nixos-setup" that should be in your home dir
Finally Run this to build 
```
sudo nixos-rebuild switch --upgrade --impure --flake .
```
