1.Make sure to make The Default System Config.
```
sudo nixos-generate-config --root /mnt
```
2.Go To /etc/nixos Then Uncomment
```
networking.networkmanager.enable = true;
```
Then Change the user name from "alice" to "anas" so my config works properly, Then Excute
```
sudo nixos-install
```
3.After Installation do
```
nix-shell -p git
```
So You add git to your shell temporarily, Then Clone This Repo to "/home/anas" using 
```
git clone https://github.com/DAnaselo/Nixos-setup.git
```
4.go to /etc/nixos and copy "hardware-configuration.nix" then but it into the "Nixos-setup" that should be in your home dir
Finally Run this to build 
```
sudo nixos-rebuild switch --upgrade --impure --flake .
```
5.Enjoy
