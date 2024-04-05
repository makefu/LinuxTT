{
  description = "Minimal NixOS installation media";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }@inputs: let
    system = "x86_64-linux"; # linuxTT is currently only available for x86_linux
  in {
    packages."${system}" = {
      isoImage = self.nixosConfigurations.isoImage.config.system.build.isoImage;
      default = self.packages."${system}".isoImage;
    };

    nixosConfigurations = {
      isoImage = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./customizations.nix
        ];
      };
    };
  };
}
