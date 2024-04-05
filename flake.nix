{
  description = "Minimal NixOS installation media";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }@inputs: let
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
    };

    nixosConfigurations = {
      isoImage = nixpkgs.lib.nixosSystem {
        inherit pkgs system;

        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./config/customizations.nix
        ];
      };
    };
  };
}
