{ pkgs, ... }:
{
  users.users.nixos.extraGroups = [ "docker" "libvirtd" "wireshark" ];
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = [ pkgs.virt-manager ];
}
