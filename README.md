* [Note](#Note)
* [Installation](#Installation)

## Installation
1. Make sure to Generate The Default System Config Using
```
sudo nixos-generate-config --root /mnt
```
2. Make Sure To Uncomment " networking.networkmanager.enable = true; " In " /etc/nixos/configuration.nix "
Then Change the user name from "alice" to "anas" so my config works properly, Then Execute
```
sudo nixos-install
```
3. After Installation do
```
nix-shell -p git
```
So You add git to your shell temporarily, Then Clone This Repo to "/home/anas" using 
```
git clone https://github.com/DAnaselo/Nixos-setup.git
```
4. go to /etc/nixos and copy "hardware-configuration.nix" then put it into the "Nixos-setup" that should be in your home dir
Finally, Run this to build 
```
sudo nixos-rebuild switch --upgrade --impure --flake .
```
5. Enjoy
## Note
If You Want To Update Your Packages, Execute This Command In Your "Nixos-setup" Folder
```
sudo nix flake update
```
.... And Please For The Love of God Do This Everytime you Rebuild/Update Your System To Have Good Hygiene ;)
```
sudo nix-collect-garbage -d
```
