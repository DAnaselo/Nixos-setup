{
  description = "My System";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in {
  nixosConfigurations = {
    nixos = lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
	      home-manager.nixosModules.home-manager
	       {
	          home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.anas = import ./home.nix;
         }
       ];
     };
   };
 }; 
}
