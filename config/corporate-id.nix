{ lib, config, pkgs, ... }: {
  isoImage.isoBaseName = "LinuxTT";
  system.nixos.distroName = "LinuxTT";
  isoImage.volumeID = "linuxtt-${config.system.nixos.release}-${pkgs.stdenv.hostPlatform.uname.processor}";

}
