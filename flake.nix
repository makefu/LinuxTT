{
  description = "Minimal NixOS installation media";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.plasma-manager = {
    url = "github:pjones/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, disko }@inputs: let
    system = "x86_64-linux"; # TTLinux is currently only available for x86_linux
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
      buildDiskImage = self.nixosConfigurations.diskImage.config.system.build.diskoImagesScript;
    };

    devShells."${system}".default = pkgs.mkShellNoCC {
      buildInputs = [ pkgs.qemu_kvm pkgs.imagemagick ];
    };

    nixosConfigurations = {
      isoImage = nixpkgs.lib.nixosSystem {
        inherit pkgs system;

        modules = [
          #"${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-plasma5.nix" 
          ./config/iso/customizations.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
          }
        ];
      };
      diskImage = nixpkgs.lib.nixosSystem {
        inherit pkgs system;

        modules = [
          disko.nixosModules.disko
          ./config/disk/customizations.nix
          ./config/disk/hybrid.nix

          "${nixpkgs}/nixos/modules/profiles/all-hardware.nix"
          "${nixpkgs}/nixos/modules/profiles/base.nix"
          "${nixpkgs}/nixos/modules/profiles/installation-device.nix"
        ];
      };
    };
  };
}
