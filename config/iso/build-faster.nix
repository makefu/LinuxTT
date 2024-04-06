{ lib, ... }:
{
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
  boot.supportedFilesystems.zfs = lib.mkForce false;
}
