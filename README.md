1.Make sure to make The Default System Config.
```
sudo nixos-generate-config --root /mnt
```
2.Uncomment The network configuration line And Change the user name from "alice" to "anas" so my config would work properly
Just Clone This Repo into Your Home Directory.
Then go to /etc/nixos and copy "hardware-configuration.nix" then but it into the "Nixos-setup" that should be in your home dir
Finally Run this to build 
```
sudo nixos-rebuild switch --upgrade --impure --flake .
```
