{ pkgs, ... }:
{
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  environment.systemPackages = with pkgs; [
    p7zip
    parted
    xrdp
    tmux
    curl
    wget
    htop
    # tightvnc
  ];
}
