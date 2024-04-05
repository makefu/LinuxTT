{ lib, ... }: {
  isoImage.isoBaseName = "LinuxTT";
  system.nixos.distroName = "LinuxTT";
  isoImage.volumeID = "linuxtt-${config.system.nixos.re.ease}-${pkgs.stdenv.hostPlatform.uname.processor}";

}
