{ config, lib, ... }:
let
  user = "linus";
in
{
  options.linuxtt.user = lib.mkOption {
    default = user;
    type = lib.types.str;
  };

  # remove old user
  users.users.nixos = lib.mkForce {};

  services.xserver.displayManager.gdm.autoLogin.user = lib.mkForce user;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "plugdev" "dialout" ];
    initialHashedPassword = "";
  };
  services.getty.autologinUser = lib.mkForce user;

  services.getty.helpLine = lib.mkForce ''
    The "${user}" and "root" accounts have empty password.
    To log in over ssh you must set a password for either "nixos" or "root"
    with `passwd` (prefix with `sudo` for "root"), or add your public key to
    /home/nixos/.ssh/authorized_keys or /root/.ssh/authorized_keys.

    Have fun!
  '';
  nix.settings.trusted-users = lib.mkForce [ user "root" ];
}
