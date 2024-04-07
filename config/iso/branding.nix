{ lib, config, pkgs, ... }: {
  isoImage.isoBaseName = "Tech Tips Linux";
  system.nixos.distroName = "Tech Tips Linux";
  isoImage.volumeID = "ttlinux-${config.system.nixos.release}-${pkgs.stdenv.hostPlatform.uname.processor}";
  isoImage.appendToMenuLabel = " LiveCD";

  isoImage.splashImage = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/a9e05d7deb38a8e005a2b52575a3f59a63a4dba0/bootloader/isolinux/bios-boot.png";
    sha256 = "1wp822zrhbg4fgfbwkr7cbkr4labx477209agzc0hr6k62fr6rxd";
  };

}
