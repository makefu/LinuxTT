{
  description = "Minimal NixOS installation media";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs,disko }@inputs: let
    system = "x86_64-linux"; # linuxTT is currently only available for x86_linux
    pkgs = (import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "python-2.7.18.8"
          "tightvnc-1.3.10"
        ];
      };
    });
  in {
    packages."${system}" = {
      isoImage = self.nixosConfigurations.isoImage.config.system.build.isoImage;
      default = self.packages."${system}".isoImage;
      diskImage = self.nixosConfigurations.diskImage.config.system.build.diskoImagesScript;
    };

    nixosConfigurations = {
      isoImage = nixpkgs.lib.nixosSystem {
        inherit pkgs system;

        modules = [
          disko.nixosModules.disko
          #"${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-plasma5.nix" 
          ./config/iso/customizations.nix
        ];
      };
      diskImage = nixpkgs.lib.nixosSystem {
        inherit pkgs system;

        modules = [
          ./config/disk/hybrid.nix
          ./config/disk/customizations.nix
        ];
      };
    };
  };
}
