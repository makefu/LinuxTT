{ lib, config, pkgs, ... }: {
  isoImage.isoBaseName = "TechTipsLinux";
  system.nixos.distroName = "TechTipsLinux";
  isoImage.volumeID = "ttlinux-${config.system.nixos.release}-${pkgs.stdenv.hostPlatform.uname.processor}";
  isoImage.appendToMenuLabel = " LiveCD";

  isoImage.splashImage = ../../assets/grub/1.png;
  # isoImage.efiSplashImage = ../../assets;
  # isoImage.grubTheme
}
